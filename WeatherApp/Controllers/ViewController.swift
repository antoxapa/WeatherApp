//
//  ViewController.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/23/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var headerView = HeaderView()
    private var model: OfferModel?
    
    private var secondHeaderView = SecondHeaderView()
    private let networkManager = NetworkManager()
    private var dataManager: DataManagerProtocol = DataManager()
    
    private let locationManager = CLLocationManager()
    
    private var headerViewHeight: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupToolBar()
        setupHeaderView()
        setupCollectionView()
        setupPanGestureRecognizer()
        
        dataManager.retrieveData(from: CoreDataManager.shared.viewContext(), data: { (model) in
            guard let model = model else { return }
            self.model = model
            self.updateViews(withModel: model)
        }, onError: { (error) in
            self.showErrorAlert(withTitle: "Error", message: error?.localizedDescription)
        })
        
        setupLocationManager()
        
    }
    
    private func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        enableBasicLocationServices()
        
    }
    
    private func setupHeaderView () {
        
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: UIScreen.main.bounds.height / 2))
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
    
    private func setupPanGestureRecognizer() {
        
        guard let tap = tableView?.panGestureRecognizer else { return }
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.tableView.tableFooterView = UIView()
        
    }
    
    private func setupToolBar() {
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.6)
        topBorder.backgroundColor = UIColor.white.cgColor
        self.navigationController?.toolbar.layer.addSublayer(topBorder)
        
    }
    
    private func downloadData(withLatitude latitude: Double, longitude: Double) {
        
        networkManager.getWeather(forLatitude: latitude, longitude: longitude, result: { (model) in
            guard let model = model else { return }
            self.model = model
            DispatchQueue.main.async { [weak self] in
                self?.updateViews(withModel: model)
                self?.dataManager.save(data: model, in: CoreDataManager.shared.newBackgroundContext(), onError: { (error) in
                    self?.showErrorAlert(withTitle: "Error", message: error?.localizedDescription)
                })
            }
        }) { [weak self] (error) in
            DispatchQueue.main.async {
                self?.showErrorAlert(withTitle: "Error", message: error?.localizedDescription)
            }
        }
        
    }
    
    private func getWeather() {
        
        var currentLocation: CLLocation?
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
            currentLocation = locationManager.location
        } else {
            showErrorAlert(withTitle: "Error", message: "Cant get location")
            return
        }
        if let latitude = currentLocation?.coordinate.latitude,
            let longitude = currentLocation?.coordinate.longitude {
            downloadData(withLatitude: latitude, longitude: longitude)
        }
        
    }
    
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            guard let weekdaysWeatherCell = tableView.dequeueReusableCell(withIdentifier: "WeekdaysCell") as? WeekdaysWeatherCell else { return UITableViewCell() }
            if let model = model?.daily {
                weekdaysWeatherCell.updateViews(with: model)
            }
            return weekdaysWeatherCell
            
        }
        if indexPath.row == 1 {
            
            guard let weatherTextCell = tableView.dequeueReusableCell(withIdentifier: "TextWeatherCell") as? TextWeatherCell else { return UITableViewCell() }
            
            if let model = model?.current {
                weatherTextCell.configure(withItem: TextWeatherItem(with: model))
            }
            
            return weatherTextCell
            
        }
        if indexPath.row == 2 {
            guard let extraWeatherCell = tableView.dequeueReusableCell(withIdentifier: "ExtraWeatherInfoCell") as? ExtraWeatherInfoCell else { return UITableViewCell() }
            
            if let model = model {
                extraWeatherCell.configure(withModel: model)
            }
            
            return extraWeatherCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height - headerView.frame.height - secondHeaderView.frame.height - 80
        }
        if indexPath.row == 1 {
            return UIScreen.main.bounds.height / 7
        }
        if indexPath.row == 2 {
            return UIScreen.main.bounds.height / 3
        }
        return UITableView.automaticDimension
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = -scrollView.contentOffset.y - secondHeaderView.frame.height
        let height = max(y, UIScreen.main.bounds.height / 7)
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: height)
        secondHeaderView.frame = CGRect(x: 0, y: headerView.bounds.height, width: view.bounds.width, height: UIScreen.main.bounds.height / 7)
        
        
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func enableBasicLocationServices() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            self.showErrorAlert(withTitle: "Error", message: "Location services are disabled on your device. In order to use this app, go to " +
                "Settings → Privacy → Location Services and turn location services on.")
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            getWeather()
            break
        @unknown default:
            self.showErrorAlert(withTitle: "Error", message: "Unknown error")
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            self.showErrorAlert(withTitle: "Error", message: "Location services are disabled on your device. In order to use this app, go to " +
                "Settings → Privacy → Location Services and turn location services on.")
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            getWeather()
            break
        @unknown default:
            self.showErrorAlert(withTitle: "Error", message: "Unknown error")
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        getWeather()
        
    }
    
}
