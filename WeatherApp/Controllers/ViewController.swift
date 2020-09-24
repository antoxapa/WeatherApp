//
//  ViewController.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/23/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var headerView = HeaderView()
    
    private var collectionView = SecondHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderView()
        setupCollectionView()
        
        guard let tap = tableView?.panGestureRecognizer else { return }
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        self.tableView.tableFooterView = UIView()
        
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
        
        collectionView.frame = CGRect(x: 0, y: headerView.frame.height, width: view.bounds.width, height: UIScreen.main.bounds.height / 7)
        collectionView.backgroundColor  = #colorLiteral(red: 0.1768635809, green: 0.686615169, blue: 0.9441607594, alpha: 1)
        self.view.addSubview(collectionView)
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        
        if indexPath.row == 0 {
        guard let weekdayCell = tableView.dequeueReusableCell(withIdentifier: "WeekdaysCell") as? WeekdaysWeatherCell else { return UITableViewCell() }
        return weekdayCell
        }
        if indexPath.row == 1 {
            guard let weatherTextCell = tableView.dequeueReusableCell(withIdentifier: "TextWeatherCell") as? TextWeatherCell else { return UITableViewCell() }
        return weatherTextCell
        }
        if indexPath.row == 2 {
            guard let extraWeatherCell = tableView.dequeueReusableCell(withIdentifier: "ExtraWeatherInfoCell") as? ExtraWeatherInfoCell else { return UITableViewCell() }
        return extraWeatherCell
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height - headerView.frame.height - collectionView.frame.height - 80
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
        
        let y = -scrollView.contentOffset.y - collectionView.frame.height
        let height = max(y, UIScreen.main.bounds.height / 7)
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: height)
        collectionView.frame = CGRect(x: 0, y: headerView.bounds.height, width: view.bounds.width, height: UIScreen.main.bounds.height / 7)
        //            if scrollView.contentOffset.y < 0 {
        //                let offset = max(height, 0)
        //                headerView.decrementColorAlpha(offset: offset)
        //            }
        
        //
        //        headerView.incrementColorAlpha(self.headerHeightConstraint.constant)
        //        headerView.incrementArticleAlpha(self.headerHeightConstraint.constant)
        //        } else if scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 65 {
        //        self.headerHeightConstraint.constant -= scrollView.contentOffset.y/100
        //        headerView.decrementColorAlpha(scrollView.contentOffset.y)
        //        headerView.decrementArticleAlpha(self.headerHeightConstraint.constant)
        //        if self.headerHeightConstraint.constant < 65 {
        //        self.headerHeightConstraint.constant = 65
        //        }
        
    }
    
}


