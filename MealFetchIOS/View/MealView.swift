//
//  MealView.swift
//  MealFetchIOS
//
//  Created by Dylan  Tao on 9/19/23.
//

import SwiftUI

struct MealView: View {
    @ObservedObject var ViewModel = MealViewModel()
    @Binding var selectedMeal: Meal.MealData?
    @Binding var pushView: Bool
    
    var body: some View {
                
        List(ViewModel.meals) { meal in
            Button {
                selectedMeal = meal
                pushView.toggle()
            } label: {
                HStack(spacing: 15) {
                    
                    RemoteImage(urlString: meal.strMealThumb)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipShape(Rectangle())
                        .cornerRadius(10.0)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(meal.strMeal)
                            .font(.headline)
                    }
                }
            }
        }
        .onAppear {
            ViewModel.fetchMeals()
        }
    }
}

//struct MealView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealView()
//    }
//}
