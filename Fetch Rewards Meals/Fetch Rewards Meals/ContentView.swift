//
//  ContentView.swift
//  Fetch Rewards Meals
//
//  Created by Luis Samayoa on 6/7/24.
//

import SwiftUI

struct ContentView: View {
    @State var showSideMenu = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationStack {
            MealsListView()
        } 
    }
}

#Preview {
    ContentView()
}
