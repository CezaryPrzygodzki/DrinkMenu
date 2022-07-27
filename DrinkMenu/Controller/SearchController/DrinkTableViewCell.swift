//
//  DrinkTableViewCell.swift
//  DrinkMenu
//
//  Created by Cezary Przygodzki on 27/07/2022.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {

    private let nameLabel = UILabel()
    private let drinkImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = UIColor(red: 60/255, green: 78/255, blue: 90/255, alpha: 1)
        contentView.addSubview(drinkImageView)
        drinkImageView.translatesAutoresizingMaskIntoConstraints = false
        drinkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        drinkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        drinkImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        drinkImageView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        
        
        
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont(name: "Times New Roman", size: 20)
        nameLabel.textColor = .white

        nameLabel.numberOfLines = 0
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 160).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
     }
    
    func setName(name: String){
        nameLabel.text = name
    }
    func setPhoto(image: UIImage){
        drinkImageView.image = image
    }
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
