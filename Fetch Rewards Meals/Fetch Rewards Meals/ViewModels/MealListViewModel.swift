//
//  MealListViewModel.swift
//  Fetch Rewards Meals
//
//  Created by Luis Samayoa on 6/7/24.
//

import Foundation

/// ViewModel that holds business logic for the meals screen.
class MealListViewModel: ObservableObject {
    // Meals to display
    @Published var meals: [Meal]?
    // Determine if meals list is currently loading
    @Published var isLoading: Bool = false
    
    init(meals: [Meal] = []) {
        self.meals = meals
        
        // Load the meals only once as opposed to every single time we return to the list
        Task {
            await getMeals()
        }
    }
    
    /// Fetches meals from the mealdb
    @MainActor
    func getMeals() async {
        self.isLoading = true

        // Make URL from mealdb string
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Error, cannot make url.")
            isLoading = false
            return
        }
        
        // Fetch meals
        let response = await APIRequestHandler.makeRequest(url: url, expectedTypeResp: MealResponse.self)
        meals = response?.meals.sorted(by: { $0.strMeal < $1.strMeal })
        isLoading = false
    }
}
