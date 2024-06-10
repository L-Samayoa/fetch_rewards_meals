//
//  Model.swift
//  Fetch Rewards Meals
//
//  Created by Luis Samayoa on 6/7/24.
//

import Foundation

/// Response we get from https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
struct MealResponse: Codable, Hashable {
    let meals: [Meal]
}

/// Each individual meal from the MealResponse
struct Meal: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
