//
//  IngredientsCollectionViewCell.swift
//  DrinkMenu
//
//  Created by Cezary Przygodzki on 27/07/2022.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
    
    private let label = UILabel()
    override init(frame: CGRect) {
            super.init(frame: frame)
        addSubview(label)
        
        backgroundColor = UIColor(red: 115/255, green: 130/255, blue: 140/255, alpha: 1)
        label.textColor = UIColor(red: 36/255, green: 52/255, blue: 63/255, alpha: 1)
        label.font = UIFont(name: "Times New Roman", size: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelTitle(name: String){
        label.text = name
    }
    
    
}
