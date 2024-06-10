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
            // Image of Meal
            AsyncImage(url: URL(string: viewModel.mealDetails?.strMealThumb ?? "")) { result in
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
            Spacer()
            
            // Meal name
            Text(viewModel.mealDetails?.strMeal ?? "")
                .font(.system(.title))
                .bold()
                .padding(.bottom, 25)
            
            // List of instructions
            List(viewModel.mealDetails?.ingredients ?? [], id: \.self) { ingredient in
                Text("\(ingredient.ingredientName): \(ingredient.measurement)")
                    .listRowBackground(Color.orange.opacity(0.5))
            }
            .listStyle(.plain)
        }
        .background(Color.purple.opacity(0.5))
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
