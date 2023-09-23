//
//  ViewModel.swift
//  MealFetchIOS
//
//  Created by Dylan  Tao on 9/19/23.
//

import SwiftUI

class MealViewModel: ObservableObject {
    @Published var meals: [Meal.MealData] = []
    @Published var mealDetails: MealDetails?
    
    func fetchMealDetails(id idMeal: String) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data:", error)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([String: [MealDetails]].self, from: data)
                if let meal = decodedData["meals"] {
                    print(meal)
                    DispatchQueue.main.async {
                        self.mealDetails = meal.first
                    }
                }
            } catch {
                print("Error decoding data:", error)
            }
        }.resume()
    }
    
    func fetchMeals() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data:", error)
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([String: [Meal.MealData]].self, from: data)
                if let meals = decodedData["meals"] {
//                    print("Fetched \(meals.count) meals")
                    DispatchQueue.main.async {
                        self.meals = meals
                    }
                }
            } catch {
                print("Error decoding data:", error)
            }
        }.resume()
    }
}
