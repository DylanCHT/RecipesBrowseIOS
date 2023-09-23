//
//  MealDetailView.swift
//  MealFetchIOS
//
//  Created by Dylan  Tao on 9/19/23.
//

import SwiftUI

struct MealDetailView: View {
    

    @StateObject var ViewModel = MealViewModel()
    @Binding var selectedMeal: Meal.MealData?
    @State private var isExpanded = false
        
    var body: some View {
        if selectedMeal != nil {
            VStack {
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        RemoteImage(urlString: selectedMeal!.strMealThumb)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.width/1.3)
                            .clipShape(Rectangle())
                            .cornerRadius(20.0)
                            .shadow(color: .black,radius: 20.0, y: 10.0)
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(ViewModel.mealDetails?.strMeal ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text("Instruction: ")
                                    .font(.body)
                                    .fontWeight(.bold)
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(isExpanded ? ViewModel.mealDetails?.strInstructions ?? "" : String(ViewModel.mealDetails?.strInstructions.prefix(1000) ?? ""))
                                        .foregroundColor(.gray)
                                        .font(.body)
                                        .lineLimit(isExpanded ? nil : 2)
                                    
                                    Button(action: {
                                        withAnimation {
                                            isExpanded.toggle()
                                        }
                                    }) {
                                        Text(isExpanded ? "Read Less" : "Read More")
                                    }
                                }
                                .padding(.horizontal)
                                .animation(.easeInOut(duration: 0.5))
                                
                                Text("Ingredients: ")
                                    .font(.body)
                                    .fontWeight(.bold)
                                
                                LazyVStack(alignment: .leading, spacing: 10) {
                                    ForEach(ViewModel.mealDetails?.strIngredients ?? [], id: \.id) { ingredient in
                                        HStack {
                                            Text(ingredient.name)
                                                .font(.body)
                                            Text(ingredient.measure)
                                                .font(.caption)
                                                .foregroundColor(Color.gray)
                                        }
                                     }
                                }
                                .padding(.horizontal)
                            }
                            .padding()
                        }
                    }.ignoresSafeArea()
                }
            }
            .onAppear {
                ViewModel.fetchMealDetails(id: selectedMeal?.idMeal ?? "")
            }
        }
    }
}

//struct MealDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MealDetailView()
//    }
//}
