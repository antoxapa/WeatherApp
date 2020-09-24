//
//  WeekdaysWeatherCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class WeekdaysWeatherCell: UITableViewCell {
    
    @IBOutlet weak var weekdaysTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weekdaysTableView.delegate = self
        weekdaysTableView.dataSource = self
        weekdaysTableView.register(UINib(nibName: "WeekdayCell", bundle: nil), forCellReuseIdentifier: "WeekdayCell")
        weekdaysTableView.tableFooterView = UIView()
        
    }
    
}

extension WeekdaysWeatherCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 9
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekdayCell", for: indexPath) as? WeekdayCell else { return UITableViewCell() }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 9
        
    }
    
}
