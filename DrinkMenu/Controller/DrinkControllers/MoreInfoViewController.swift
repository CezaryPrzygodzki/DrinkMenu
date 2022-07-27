//
//  MoreInfoViewController.swift
//  DrinkMenu
//
//  Created by Cezary Przygodzki on 27/07/2022.
//

import UIKit

class MoreInfoViewController: UIViewController {

    
    var idDrink: String!
    var photoImage: UIImage!
    
    private let scrollView = UIScrollView()
    private let conteinerView = UIView()
    private var heightOfScrollView: CGFloat = 0
    
    private let drinkImageView = UIImageView()
    private let descriptionLabel = UILabel()
    
    private let ingredientsCollectionViewReuseIdentifier = "ingredientsCollectionViewReuseIdentifier"
    private var ingredientsCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let dh = DataHelper()

        var moreInfoDrink: MoreInfo!
        dh.getMoreInfoDrinkData(id: idDrink) { result in
            print(result?.drinks[0].strDrink)
            if let rsl = result {
                moreInfoDrink = rsl
                DispatchQueue.main.async { [self] in
                    view.addSubview(scrollView)
                    scrollView.translatesAutoresizingMaskIntoConstraints = false
                    scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                    scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                    scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                    
                    scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2000)
                    
                    scrollView.addSubview(conteinerView)
                    conteinerView.frame.size = CGSize(width: view.frame.size.width, height: 2000)
                    
                        conteinerView.addSubview(drinkImageView)
                        configureImageView()
                    
                    
                    
                    conteinerView.addSubview(descriptionLabel)
                    configureDescriptionLabel(moreInfoDrink: moreInfoDrink)
                    
                    configureIngredientsCollectionView()
                    
                }
            }
                
        }
    }
    
    func setPhoto(image: UIImage!){
        drinkImageView.image = image
    }

    private func configureImageView(){
        drinkImageView.translatesAutoresizingMaskIntoConstraints = false
        drinkImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 25).isActive = true
        drinkImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 25).isActive = true
        drinkImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -25).isActive = true
        drinkImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        
        drinkImageView.backgroundColor = .red
    }
    
    private func configureDescriptionLabel(moreInfoDrink: MoreInfo){
        descriptionLabel.text = moreInfoDrink.drinks[0].strInstructions
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: drinkImageView.bottomAnchor, constant: 25).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 25).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -25).isActive = true
    }
    private func configureIngredientsCollectionView(){
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        
        layout.estimatedItemSize = CGSize(width: 60, height: 25) //since the labels are "auto-self-sizing", the height is actual height of the cell
        ingredientsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ingredientsCollectionView.dataSource = self
        ingredientsCollectionView.delegate = self
        
        ingredientsCollectionView.backgroundColor = .white
        ingredientsCollectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: ingredientsCollectionViewReuseIdentifier)
        
        conteinerView.addSubview(ingredientsCollectionView)
        ingredientsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        ingredientsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        ingredientsCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25).isActive = true
        ingredientsCollectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 600).isActive = true

}
    
    
    
}

extension MoreInfoViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return moreInfo?.topics.count ?? 0
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ingredientsCollectionViewReuseIdentifier, for: indexPath) as! IngredientsCollectionViewCell
        
        //cell.setLabelTitle(name: moreInfo.topics[indexPath.row])
        cell.setLabelTitle(name: "Whiskey")
        return cell
    }
}
