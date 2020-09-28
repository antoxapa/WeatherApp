//
//  ViewController.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/23/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit
import CoreLocation

enum WeatherTableRow: Int {
    
    case weekdays = 0
    case today
    case extraInfo
    
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var headerView = MainWeatherHeaderView()
    private var model: OfferModel?
    
    private var secondHeaderView = HourlyWeatherHeaderView()
    private let networkManager = NetworkManager()
    private var dataManager: DataManagerProtocol = DataManager()
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupToolBar()
        setupHeaderView()
        setupCollectionView()
        setupPanGestureRecognizer()
        
        getCoreData()
        
        setupLocationManager()
        
    }
    
    private func setupHeaderView () {
        
        headerView = MainWeatherHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: UIScreen.main.bounds.height / 2))
        headerView.backgroundColor = #colorLiteral(red: 0.1768635809, green: 0.686615169, blue: 0.9441607594, alpha: 1)
        self.view.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: headerView.frame.height + tableView.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = #colorLiteral(red: 0.1768635809, green: 0.686615169, blue: 0.9441607594, alpha: 1)
        
        tableView.register(UINib(nibName: "WeekdaysWeatherCell", bundle: nil), forCellReuseIdentifier: "WeekdaysCell")
        tableView.register(UINib(nibName: "TextWeatherCell", bundle: nil), forCellReuseIdentifier: "TextWeatherCell")
        tableView.register(UINib(nibName: "ExtraWeatherInfoCell", bundle: nil), forCellReuseIdentifier: "ExtraWeatherInfoCell")
        
    }
    
    private func setupCollectionView() {
        
        secondHeaderView.frame = CGRect(x: 0, y: headerView.frame.height, width: view.bounds.width, height: UIScreen.main.bounds.height / 7)
        secondHeaderView.backgroundColor  = #colorLiteral(red: 0.1768635809, green: 0.686615169, blue: 0.9441607594, alpha: 1)
        self.view.addSubview(secondHeaderView)
        
    }
    
    private func setupToolBar() {
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.6)
        topBorder.backgroundColor = UIColor.white.cgColor
        self.navigationController?.toolbar.layer.addSublayer(topBorder)
        
    }
    
    private func setupPanGestureRecognizer() {
        
        guard let tap = tableView?.panGestureRecognizer else { return }
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.tableView.tableFooterView = UIView()
        
    }
    
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        enableBasicLocationServices()
        
    }
    
}

extension MainViewController {
    
    //    MARK: - Updating
    
    private func updateViews(withModel model: OfferModel) {
        
        headerView.updateViews(withItem: CurrentWeatherItem(withModel: model))
        
        guard let items = model.hourly else { return }
        var hourItems = [HourWeatherItem]()
        
        for item in items {
            let hourWeather = HourWeatherItem(withModel: item)
            hourItems.append(hourWeather)
        }
        secondHeaderView.updateViews(with: hourItems)
        tableView.reloadData()
    }
    
    private func showErrorAlert(withTitle title: String?, message: String?) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(action)
        self.present(ac, animated: true)
        
    }
    
}

extension MainViewController {
    
    // MARK: - Get Data
    
    private func getWeather() {
        
        var currentLocation: CLLocation?
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
            currentLocation = locationManager.location
        } else {
            showErrorAlert(withTitle: i20n.error_title, message: i20n.locationUnknown)
            return
        }
        if let latitude = currentLocation?.coordinate.latitude,
            let longitude = currentLocation?.coordinate.longitude {
            downloadData(withLatitude: latitude, longitude: longitude)
        }
        
    }
    
    private func downloadData(withLatitude latitude: Double, longitude: Double) {
        
        networkManager.getWeather(forLatitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let model):
                self?.model = model
                DispatchQueue.main.async { [weak self] in
                    self?.updateViews(withModel: model)
                    self?.dataManager.save(data: model, in: CoreDataManager.shared.newBackgroundContext(), onError: { (error) in
                        self?.showErrorAlert(withTitle: i20n.error_title, message: error?.localizedDescription)
                    })
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showErrorAlert(withTitle: i20n.error_title, message: error.localizedDescription)
                }
            }
        }
        
    }
    
    private func getCoreData() {
        
        dataManager.retrieveData(from: CoreDataManager.shared.viewContext()) { [weak self] result in
            
            switch result {
                
            case .success(let model):
                guard let model = model else { return }
                self?.model = model
                self?.updateViews(withModel: model)
                
            case .failure(let error):
                self?.showErrorAlert(withTitle: i20n.error_title, message: error.localizedDescription)
                
            }
        }
        
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    //    MARK: - TableView DataSource + Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = WeatherTableRow(rawValue: indexPath.row) else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.backgroundColor = .clear
            return cell
        }
        
        switch row {
            
        case .weekdays:
            guard let weekdaysWeatherCell = tableView.dequeueReusableCell(withIdentifier: "WeekdaysCell") as? WeekdaysWeatherCell else { return UITableViewCell() }
            if let model = model?.daily {
                weekdaysWeatherCell.updateViews(with: model)
            }
            return weekdaysWeatherCell
            
        case .today:
            guard let weatherTextCell = tableView.dequeueReusableCell(withIdentifier: "TextWeatherCell") as? TextWeatherCell else { return UITableViewCell() }
            
            if let model = model?.current {
                weatherTextCell.configure(withItem: TextWeatherItem(with: model))
            }
            
            return weatherTextCell
            
        case .extraInfo:
            guard let extraWeatherCell = tableView.dequeueReusableCell(withIdentifier: "ExtraWeatherInfoCell") as? ExtraWeatherInfoCell else { return UITableViewCell() }
            
            if let model = model {
                extraWeatherCell.configure(withModel: model)
            }
            
            return extraWeatherCell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let row = WeatherTableRow(rawValue: indexPath.row) else { return UITableView.automaticDimension }
        switch row {
        case .weekdays:
            return UIScreen.main.bounds.height - headerView.frame.height - secondHeaderView.frame.height - 80
            
        case .today:
            return UIScreen.main.bounds.height / 7
        case .extraInfo:
            return UIScreen.main.bounds.height / 3
            
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = -scrollView.contentOffset.y - secondHeaderView.frame.height
        let height = max(y, UIScreen.main.bounds.height / 7)
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: height)
        secondHeaderView.frame = CGRect(x: 0, y: headerView.bounds.height, width: view.bounds.width, height: UIScreen.main.bounds.height / 7)
        
        let offset = scrollView.contentOffset.y + scrollView.contentInset.top
        headerView.updateLabelsAlpha(using: offset)
        
    }
    
}

extension MainViewController: CLLocationManagerDelegate {
    
    //    MARK: - Location manager delegate
    
    func enableBasicLocationServices() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            self.showErrorAlert(withTitle: i20n.error_title, message: i20n.locationDisabled)
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            getWeather()
            break
        @unknown default:
            self.showErrorAlert(withTitle: i20n.error_title, message: i20n.locationUnknown)
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            self.showErrorAlert(withTitle: i20n.error_title, message: i20n.locationDisabled)
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            getWeather()
            break
        @unknown default:
            self.showErrorAlert(withTitle: i20n.error_title, message: i20n.locationUnknown)
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        getWeather()
        
    }
    
}
