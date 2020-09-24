//
//  SecondHeaderView.swift
//  WheatherApp
//
//  Created by Антон Потапчик on 9/24/20.
//  Copyright © 2020 TonyPo Production. All rights reserved.
//

import UIKit

class SecondHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubviews()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
        
    }
    
    private func initSubviews() {
        
        let nib = UINib(nibName: "SecondHeaderView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "HourWeatherCell", bundle: nil), forCellWithReuseIdentifier: "HourCell")
        
    }
    
}

extension SecondHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 48
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourCell", for: indexPath) as? HourWeatherCell else { return UICollectionViewCell() }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
    
}
