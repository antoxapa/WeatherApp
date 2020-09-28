//
//  WeekdaysWeatherCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class WeekdaysWeatherCell: UITableViewCell {
    
    @IBOutlet private weak var weekdaysTableView: UITableView!
    private var itemsArray: [DailyOfferModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weekdaysTableView.delegate = self
        weekdaysTableView.dataSource = self
        weekdaysTableView.register(UINib(nibName: "WeekdayCell", bundle: nil), forCellReuseIdentifier: "WeekdayCell")
        weekdaysTableView.tableFooterView = UIView()
        
    }
    
    func updateViews(with items: [DailyOfferModel]) {
        
        self.itemsArray = items
        weekdaysTableView.reloadData()
        
    }
    
}

extension WeekdaysWeatherCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekdayCell", for: indexPath) as? WeekdayCell else { return UITableViewCell() }
        
        
        if let model = itemsArray?[indexPath.row] {
            
            cell.configure(with: WeekdayWeatherItem(withModel: model))
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let count = itemsArray?.count else { return 0 }
        return tableView.frame.height / CGFloat(count)
        
    }
    
}
