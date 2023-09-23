//
//  ContentView.swift
//  MealFetchIOS
//
//  Created by Dylan  Tao on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedMeal: Meal.MealData?
    @State private var pushView: Bool = false
    
    var body: some View {
        NavigationStack {
            MealView(selectedMeal: $selectedMeal, pushView: $pushView)
                .navigationTitle("Meals")
                .navigationDestination(isPresented: $pushView) {
                        MealDetailView(selectedMeal: $selectedMeal)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
