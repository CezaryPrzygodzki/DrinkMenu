//
//  MoreInfoViewController.swift
//  DrinkMenu
//
//  Created by Cezary Przygodzki on 27/07/2022.
//

import UIKit

class MoreInfoViewController: UIViewController {

    private var idDrink: String!
    private var photoImage: UIImage!
    private var ingredients: [String] = []
    
    private let scrollView = UIScrollView()
    private let conteinerView = UIView()
    private var heightOfScrollView: CGFloat = 0
    
    private let drinkImageView = UIImageView()
    private let square = UIView()
    private let descriptionLabel = UILabel()
    
    private let ingredientsCollectionViewReuseIdentifier = "ingredientsCollectionViewReuseIdentifier"
    private var ingredientsCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitle()
        
        let dh = DataHelper()

        dh.getMoreInfoDrinkData(id: idDrink) { result in
            var moreInfoDrink: MoreInfo!
            
            if let rsl = result {
                moreInfoDrink = rsl
                self.ingredients = self.addIngredients(moreInfoDrink: moreInfoDrink)

                dh.downloadImage(from: URL(string: moreInfoDrink.drinks[0].strDrinkThumb)!) { image in
                    self.photoImage = image
                    
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
                        
                        
                        conteinerView.addSubview(square)
                        configureSquare()
                        
                        conteinerView.addSubview(drinkImageView)
                        configureImageView(image: photoImage)

                        conteinerView.addSubview(descriptionLabel)
                        configureDescriptionLabel(moreInfoDrink: moreInfoDrink)
                        
                        configureIngredientsCollectionView()
                    }
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        reloadUI()
    }
    
    func setId(id: String){
        idDrink = id
    }
    private func reloadUI(){
        heightOfScrollView = drinkImageView.frame.size.height + 10 //height of image + 10 padding

        var height = descriptionLabel.frame.size.height
        heightOfScrollView += height + 25

        height = ingredientsCollectionView.contentSize.height //actual coll view height
        heightOfScrollView += height + 25 + 25 //padding 2 times
        ingredientsCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
        ingredientsCollectionView.layoutIfNeeded()
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: heightOfScrollView)
        conteinerView.frame.size = CGSize(width: view.frame.size.width, height: heightOfScrollView)
    }
    private func addIngredients(moreInfoDrink: MoreInfo!) -> [String] {
        var ingredients: [String] = []
        
        if moreInfoDrink.drinks[0].strIngredient1 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient1!)}
        if moreInfoDrink.drinks[0].strIngredient2 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient2!)}
        if moreInfoDrink.drinks[0].strIngredient3 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient3!)}
        if moreInfoDrink.drinks[0].strIngredient4 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient4!)}
        if moreInfoDrink.drinks[0].strIngredient5 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient5!)}
        
        if moreInfoDrink.drinks[0].strIngredient6 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient6!)}
        if moreInfoDrink.drinks[0].strIngredient7 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient7!)}
        if moreInfoDrink.drinks[0].strIngredient8 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient8!)}
        if moreInfoDrink.drinks[0].strIngredient9 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient9!)}
        if moreInfoDrink.drinks[0].strIngredient10 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient10!)}
        
        if moreInfoDrink.drinks[0].strIngredient11 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient11!)}
        if moreInfoDrink.drinks[0].strIngredient12 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient12!)}
        if moreInfoDrink.drinks[0].strIngredient13 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient13!)}
        if moreInfoDrink.drinks[0].strIngredient14 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient14!)}
        if moreInfoDrink.drinks[0].strIngredient15 != nil { ingredients.append(moreInfoDrink.drinks[0].strIngredient15!)}
        
        return ingredients
    }


    private func configureImageView(image: UIImage!){
        drinkImageView.translatesAutoresizingMaskIntoConstraints = false
        drinkImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 10).isActive = true
        drinkImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 25).isActive = true
        drinkImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -25).isActive = true
        drinkImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        
        drinkImageView.image = image
    }
    
    private func configureSquare(){
        square.translatesAutoresizingMaskIntoConstraints = false
        square.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 17).isActive = true
        square.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 32).isActive = true
        square.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -18).isActive = true
        square.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 50).isActive = true
        square.backgroundColor = UIColor(red: 115/255, green: 130/255, blue: 140/255, alpha: 1)
    }
    private func configureDescriptionLabel(moreInfoDrink: MoreInfo){
        descriptionLabel.text = moreInfoDrink.drinks[0].strInstructions
        descriptionLabel.font = UIFont(name: "Times New Roman", size: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        
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
        
        
        ingredientsCollectionView.backgroundColor = UIColor(red: 60/255, green: 78/255, blue: 90/255, alpha: 1)
        ingredientsCollectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: ingredientsCollectionViewReuseIdentifier)
        
        conteinerView.addSubview(ingredientsCollectionView)
        ingredientsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        ingredientsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        ingredientsCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25).isActive = true
        ingredientsCollectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 600).isActive = true

}
    
    
    private func configureTitle(){
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white ,  NSAttributedString.Key.font: UIFont(name: "Times New Roman", size: 35)!]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Times New Roman", size: 18)!]
        navigationController?.navigationBar.barTintColor = UIColor(red: 60/255, green: 78/255, blue: 90/255, alpha: 1)
        view.backgroundColor = UIColor(red: 60/255, green: 78/255, blue: 90/255, alpha: 1)
    }
    
    
}

extension MoreInfoViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ingredientsCollectionViewReuseIdentifier, for: indexPath) as! IngredientsCollectionViewCell
        
        cell.setLabelTitle(name: ingredients[indexPath.row])
        
        return cell
    }
}
