//
//  ViewController.swift
//  DrinkMenu
//
//  Created by Cezary Przygodzki on 27/07/2022.
//

import UIKit

class ViewController: UIViewController {

    private let ingredientLabel = UILabel()
    private let ingredientTextField = UITextField()
    private let showButton = UIButton()
    
    var ingredient: String!
    private let tableView = UITableView()
    private let tableViewCellIdentifier = "tableViewCellIdentifier"


    var drinks: Drinks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 60/255, green: 78/255, blue: 90/255, alpha: 1)
        view.addSubview(ingredientLabel)
        configureIngredientLabel()
        
        view.addSubview(ingredientTextField)
        configureIngredientTextField()
        
        view.addSubview(showButton)
        configureShowButton()
        
        view.addSubview(tableView)
        configureTableView()
        
        
        
    }

    private func configureIngredientLabel(){
        ingredientLabel.text = "Ingredient of drinks you'd like to get:"
        ingredientLabel.numberOfLines = 0
        ingredientLabel.textColor = .white
        //ingredientLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        ingredientLabel.font = UIFont(name: "Times New Roman", size: 20)
        
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        ingredientLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        ingredientLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        ingredientLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureIngredientTextField(){
        ingredientTextField.leftViewMode = .always
        ingredientTextField.layer.masksToBounds = true
        ingredientTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))

        ingredientTextField.attributedPlaceholder = NSAttributedString(string: "e.g., vodka, gin",
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        ingredientTextField.textColor = .white
        ingredientTextField.font = UIFont(name: "Times New Roman", size: 18)
        ingredientTextField.layer.borderColor = UIColor.white.cgColor
        ingredientTextField.layer.borderWidth = 2
        
        ingredientTextField.translatesAutoresizingMaskIntoConstraints = false
        ingredientTextField.topAnchor.constraint(equalTo: ingredientLabel.bottomAnchor).isActive = true
        ingredientTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        ingredientTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        ingredientTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureShowButton(){
        showButton.setTitle("Search", for: .normal)
        showButton.setTitleColor(UIColor(red: 60/255, green: 78/255, blue: 90/255, alpha: 1), for: .normal)
        showButton.titleLabel?.font = UIFont(name: "Times New Roman", size: 16)
        showButton.backgroundColor = .white
    
        showButton.addTarget(self, action: #selector(showDrinks), for: .touchUpInside)
        
        showButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.topAnchor.constraint(equalTo: ingredientTextField.bottomAnchor, constant: 10).isActive = true
        showButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        showButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        showButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func configureTableView(){
        tableView.register(DrinkTableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        setTableViewDelegates()
        tableView.rowHeight = 160
        tableView.backgroundColor = UIColor(red: 60/255, green: 78/255, blue: 90/255, alpha: 1)
        tableView.separatorColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: showButton.bottomAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    

    
    @objc private func showDrinks(_ sender: Any){
        if let drink = ingredientTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            print(drink)
            let dh = DataHelper()
            dh.getDrinksData(ingredient: drink) { result in
                if let rsl = result {
                    self.drinks = rsl
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    self.drinks = nil
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //RepositoriesHelper.shared.repositories.count
        return drinks?.drinks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? DrinkTableViewCell else {
            fatalError("Bad Instance")
        }
        let drink = drinks?.drinks[indexPath.row]
        cell.setName(name: drink?.strDrink ?? "")
        let dh = DataHelper()
        dh.downloadImage(from: URL(string: drink!.strDrinkThumb)!) { image in
            cell.setPhoto(image: image)
        }
        
        cell.separatorInset = UIEdgeInsets.init(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        cell.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 100.0, bottom: 0.0, right: 0.0)
        return cell
    }
    
    private func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Przenosi do drinka")
        let moreInfoVC = MoreInfoViewController()
        let drink = drinks?.drinks[indexPath.row]
        moreInfoVC.idDrink = drink?.idDrink
        moreInfoVC.title = drink?.strDrink
        self.navigationController?.pushViewController(moreInfoVC, animated: true)


    }
}
