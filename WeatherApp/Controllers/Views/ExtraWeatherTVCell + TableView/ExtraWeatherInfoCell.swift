//
//  ExtraWeatherInfoCell.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class ExtraWeatherInfoCell: UITableViewCell {
    
    @IBOutlet private weak var extraTableView: UITableView!
    private var model: OfferModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        extraTableView.dataSource = self
        extraTableView.delegate = self
        extraTableView.register(UINib(nibName: "InfoWeatherCell", bundle: nil), forCellReuseIdentifier: "InfoWeatherCell")
        
        extraTableView.tableFooterView = UIView()
        
    }
    
    func configure(withModel model:OfferModel) {
        
        self.model = model
        extraTableView.reloadData()
        
    }
    
}

extension ExtraWeatherInfoCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoWeatherCell", for: indexPath) as? InfoWeatherCell else { return UITableViewCell() }
        
        if let model = model {
            cell.configure(withIndex: indexPath.row, item: InfoWeatherItem(model: model))
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 5
        
    }
    
}
