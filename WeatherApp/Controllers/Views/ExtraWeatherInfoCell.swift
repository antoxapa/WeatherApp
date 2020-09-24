//
//  ExtraWeatherInfoCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class ExtraWeatherInfoCell: UITableViewCell {
    
    @IBOutlet weak var extraTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        extraTableView.dataSource = self
        extraTableView.delegate = self
        extraTableView.register(UINib(nibName: "InfoWeatherCell", bundle: nil), forCellReuseIdentifier: "InfoWeatherCell")
        
        extraTableView.tableFooterView = UIView()
    }
    
}

extension ExtraWeatherInfoCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoWeatherCell", for: indexPath) as? InfoWeatherCell else { return UITableViewCell() }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 5
        
    }
    
}
