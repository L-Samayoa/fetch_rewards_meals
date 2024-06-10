//
//  MealDetailsViewModel.swift
//  Fetch Rewards Meals
//
//  Created by Luis Samayoa on 6/7/24.
//

import Foundation

/// Holds all the business logic needed MealDetailsView
class MealDetailsViewModel: ObservableObject {
    let meal: Meal
    @Published var mealDetails: MealDetails?
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    /// Fetches meal details for a specific meal
    @MainActor
    func getMealDetails() async {
        // Make URL from mealdb string
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)") else {
            print("Error, cannot make url.")
            return
        }
        
        // Fetch meal details
        // TODO: If error, show error screen and button to refresh
        let response = await APIRequestHandler.makeRequest(url: url, expectedTypeResp: MealDetailsResponse.self)
        mealDetails = response?.meals.first
    }
}
