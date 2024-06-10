//
//  MealDetailsView.swift
//  Fetch Rewards Meals
//
//  Created by Luis Samayoa on 6/7/24.
//

import SwiftUI

struct MealDetailsView: View {
    @ObservedObject var viewModel: MealDetailsViewModel

    var body: some View {
        VStack(spacing: 0) {
            // If loading, show loading spinner
            if (viewModel.isLoading) {
                Spacer()

                ProgressView("Loading meals...")
                    .controlSize(.extraLarge)
                
                Spacer()
                
            // If meal details loaded correctly, show them
            } else if let mealDetails = viewModel.mealDetails {
                ScrollView(.vertical) {
                    // Image of Meal
                    AsyncImage(url: URL(string: mealDetails.strMealThumb)) { result in
                        switch result {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        default:
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        }
                    }
                                        
                    // Meal name
                    Text(mealDetails.strMeal)
                        .font(.system(.title))
                        .bold()
                    
                    // List of ingredients
                    VStack(spacing: 0) {
                        Text("Ingredients")
                            .bold()
                            .font(.title2)
                            .padding(.bottom, 5)
                        
                        ForEach(mealDetails.ingredients, id: \.self) { ingredient in
                            Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .background(Color.orange.opacity(0.5))
                    
                    // Instructions
                    VStack(spacing: 0) {
                        Text("Instructions")
                            .font(.title2)
                            .bold()
                            .padding(.bottom, 5)
                        
                        Text(mealDetails.strInstructions)
                            .padding(5)
                    }
                    .padding(.vertical, 5)
                }
                
            // If we have finished loading and we don't have meal details, show error and let user try again.
            } else {
                Spacer()
                
                Text("An error has occured. Please try loading the meals again.")
                    .font(.largeTitle)
                
                Button(action: {
                    Task {
                        await viewModel.getMealDetails()
                    }
                    
                }, label: {
                    Text("Reload meals")
                        .font(.largeTitle)
                        .padding(10)
                        .background(.purple.opacity(0.2))
                        .border(.yellow)
                })
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.purple.opacity(0.5))
        .toolbarBackground(Color.purple.opacity(0.5), for: .navigationBar)
        .onAppear {
            Task {
                await viewModel.getMealDetails()
            }
        }
    }
}

#Preview {
    MealDetailsView(viewModel: MealDetailsViewModel(meal: Meal(strMeal: "Apam balik",
                                                               strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                                                               idMeal: "53049")))
}
