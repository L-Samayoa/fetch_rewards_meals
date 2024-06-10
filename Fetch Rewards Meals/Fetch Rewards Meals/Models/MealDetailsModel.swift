//
//  MealDetails.swift
//  Fetch Rewards Meals
//
//  Created by Luis Samayoa on 6/7/24.
//

import Foundation

/// Response we get from https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
struct MealDetailsResponse: Codable {
    let meals: [MealDetails]
}

/// Struct for each ingredient/measurement that appears in MealDetails
struct Ingredient: Codable, Hashable {
    let ingredientName: String
    let measurement: String
}

/// Struct to hold data we need from response
struct MealDetails: Codable {
    let strMeal: String
    let strMealThumb: String
    let ingredients: [Ingredient]
    let strInstructions: String
        
    /// Specific decoder function so that we can format the MealDetails response into data we can easily work with
    init(from decoder: any Decoder) throws {
        
        // Holds the current list of ingredients (variable)
        var ingredients: [Ingredient] = []
        
        // Adds the ingredient/measurement to the ingredients list as long as both the ingredientName and measurement are not empty or nil, and that ingredient/measurement hasn't appeared before.
        func buildInstruction(ingredientName: String?, measurement: String?) {
            guard let ingredientName = ingredientName, let measurement = measurement else { return }
            
            if (!ingredientName.isEmpty && !measurement.isEmpty && !ingredients.contains(where: { $0.ingredientName == ingredientName && $0.measurement == measurement })) {
                ingredients.append(Ingredient(ingredientName: ingredientName, measurement: measurement))
            }
        }
        
        // All the coding keys for the data we need from response, including a lot of strIngredients and strMeasures
        enum CodingKeys: String, CodingKey {
            case strMeal, strMealThumb, strInstructions,
                 strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20,
                 strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        }
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        self.strInstructions = try container.decode(String.self, forKey: .strInstructions)
        
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient1), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure1))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient2), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure2))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient3), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure3))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient4), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure4))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient5), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure5))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient6), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure6))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient7), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure7))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient8), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure8))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient9), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure9))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient10), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure10))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient11), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure11))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient12), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure12))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient13), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure13))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient14), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure14))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient15), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure15))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient16), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure16))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient17), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure17))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient18), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure18))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient19), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure19))
        buildInstruction(ingredientName: try container.decodeIfPresent(String.self, forKey: .strIngredient20), measurement: try container.decodeIfPresent(String.self, forKey: .strMeasure20))
        self.ingredients = ingredients
    }
}
