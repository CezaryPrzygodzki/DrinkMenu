//
//  Drink.swift
//  DrinkMenu
//
//  Created by Cezary Przygodzki on 27/07/2022.
//
import UIKit
import Foundation

struct Drinks: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}


    struct MoreInfo: Codable {
        let drinks: [DrinkMoreInfo]
    }
    
    
    struct DrinkMoreInfo: Codable {
        let idDrink, strDrink, strInstructions: String
        let strDrinkThumb: String
        let strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15: String?
    }


class DataHelper {
    
    func getDrinksData(ingredient: String, completion: @escaping(Drinks?) -> ()){
        if let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(ingredient)"){
            URLSession.shared.dataTask(with: url) { data, responde, error in
                if let data = data {
                    do {
                        let contr = try JSONDecoder().decode(Drinks.self, from: data)
                        completion(contr)
                    } catch let error {
                        print(error)
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
    
    func getMoreInfoDrinkData(id: String, completion: @escaping(MoreInfo?) -> ()){
        if let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)"){
        URLSession.shared.dataTask(with: url) { data, responde, error in
            if let data = data {
                do {
                    let contr = try JSONDecoder().decode(MoreInfo.self, from: data)
                    completion(contr)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            }
        }.resume()
    }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completed: @escaping (UIImage) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            
            DispatchQueue.main.async() {
                if let image = UIImage(data: data) {
                    completed(image)
                } else {
                    completed(UIImage(systemName: "questionmark.square.fill")!)
                }
            }
        }
    }
}
