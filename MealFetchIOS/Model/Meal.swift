//
//  Meal.swift
//  MealFetchIOS
//
//  Created by Dylan  Tao on 9/19/23.
//

import Foundation

struct Meal: Codable {
    struct MealData: Identifiable, Codable {
        let idMeal: String
        let strMeal: String
        let strMealThumb: String
        
        // Add an id property for Identifiable conformance
        var id: String {
            idMeal
        }
    }
    
//    let meals: [Meal.MealData]
}

struct Ingredient: Identifiable, Codable {
    let id: UUID
    let name: String
    let measure: String
    
}

struct MealDetails: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    var strYoutube: String?
    var strIngredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    func encode(to encoder: Encoder) throws {}
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        strCategory = try container.decode(String.self, forKey: .strCategory)
        strArea = try container.decode(String.self, forKey: .strArea)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        
        var ingredients: [Ingredient] = []
        for i in 1...20 {
            if let ingredient = try container.decodeIfPresent(String.self, forKey: .init(stringValue: "strIngredient\(i)")!),
               let measure = try container.decodeIfPresent(String.self, forKey: .init(stringValue: "strMeasure\(i)")!),
               !ingredient.isEmpty && !measure.isEmpty {
                ingredients.append(Ingredient(id: UUID(), name: ingredient, measure: measure))
            }
        }
                
        // Assign the extracted ingredients to the ingredients property
        self.strIngredients = ingredients
    }
}

//{"meals":[{
//    "idMeal":"53049",
//    "strMeal":"Apam balik",
//    "strDrinkAlternate":null,
//    "strCategory":"Dessert",
//    "strArea":"Malaysian",
//    "strInstructions":"Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.",
//    "strMealThumb":"https:\/\/www.themealdb.com\/images\/media\/meals\/adxcbq1619787919.jpg",
//    "strTags":null,
//    "strYoutube":"https:\/\/www.youtube.com\/watch?v=6R8ffRRJcrg",
//    "strIngredient1":"Milk",
//    "strIngredient2":"Oil",
//    "strIngredient3":"Eggs",
//    "strIngredient4":"Flour",
//    "strIngredient5":"Baking Powder",
//    "strIngredient6":"Salt",
//    "strIngredient7":"Unsalted Butter",
//    "strIngredient8":"Sugar",
//    "strIngredient9":"Peanut Butter","strIngredient10":"",
//    "strIngredient11":"",
//    "strIngredient12":"",
//    "strIngredient13":"",
//    "strIngredient14":"",
//    "strIngredient15":"",
//    "strIngredient16":"",
//    "strIngredient17":"",
//    "strIngredient18":"",
//    "strIngredient19":"",
//    "strIngredient20":"",
//    "strMeasure1":"200ml",
//    "strMeasure2":"60ml",
//    "strMeasure3":"2",
//    "strMeasure4":"1600g",
//    "strMeasure5":"3 tsp",
//    "strMeasure6":"1\/2 tsp",
//    "strMeasure7":"25g",
//    "strMeasure8":"45g",
//    "strMeasure9":"3 tbs",
//    "strMeasure10":" ",
//    "strMeasure11":" ",
//    "strMeasure12":" ",
//    "strMeasure13":" ",
//    "strMeasure14":" ",
//    "strMeasure15":" ",
//    "strMeasure16":" ",
//    "strMeasure17":" ",
//    "strMeasure18":" ",
//    "strMeasure19":" ",
//    "strMeasure20":" ",
//    "strSource":"https:\/\/www.nyonyacooking.com\/recipes\/apam-balik~SJ5WuvsDf9WQ",
//    "strImageSource":null,
//    "strCreativeCommonsConfirmed":null,
//    "dateModified":null}]}
