//
//  MealListRow.swift
//  Fetch Rewards Meals
//
//  Created by Luis Samayoa on 6/7/24.
//

import SwiftUI

// Single meal row that appears on MealList
struct MealListRow: View {
    let meal: Meal
    
    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: meal.strMealThumb)) { result in
                switch result {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                default:
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                }
            }
            Spacer()
            
            Text(meal.strMeal)
        }
    }
}

#Preview {
    MealListRow(meal: Meal(strMeal: "Apam balik",
                           strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                           idMeal: "53049"))
}
