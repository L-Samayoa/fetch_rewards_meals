//
//  MealsList.swift
//  Fetch Rewards Meals
//
//  Created by Luis Samayoa on 6/7/24.
//

import SwiftUI

struct MealsListView: View {
    @ObservedObject var viewModel = MealListViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // Header
            HStack(alignment: .center, spacing: 10) {
                Image("fetch_rewards_meals_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height / 8)
                
                Text("Powered by TheMealDB")
                    .font(.system(.headline))
            }
            
            Spacer()
            
            // If loading, show loading spinner
            if (viewModel.isLoading) {
                ProgressView("Loading meals...")
                    .controlSize(.extraLarge)
                
                Spacer()
            
            // If we are not loading and we have meals, show the list
            } else if let meals = viewModel.meals, !meals.isEmpty {
                // List of meals
                List(meals, id: \.self) { meal in
                    NavigationLink {
                        withAnimation {
                            MealDetailsView(viewModel: MealDetailsViewModel(meal: meal))
                        }
                    } label: {
                        MealListRow(meal: meal)
                    }
                    .listRowBackground(Color.orange.opacity(0.5))
                }
                .listStyle(.plain)
                
            // If we have finished loading and we don't have a list or the list is empty, show error and let user try again. 
            } else {
                Text("An error has occured. Please try loading the meals again.")
                    .font(.largeTitle)
                
                Button(action: {
                    Task {
                        await viewModel.getMeals()
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
        .background(.purple.opacity(0.2))
    }
}

#Preview {
    MealsListView()
}
