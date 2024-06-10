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
    // Determine if meal details is currently loading
    @Published var isLoading: Bool = false
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    /// Fetches meal details for a specific meal
    @MainActor
    func getMealDetails() async {
        isLoading = true
        
        // Make URL from mealdb string
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)") else {
            print("Error, cannot make url.")
            isLoading = false
            return
        }
        
        // Fetch meal details
        let response = await APIRequestHandler.makeRequest(url: url, expectedTypeResp: MealDetailsResponse.self)
        mealDetails = response?.meals.first
        isLoading = false
    }
}
