//
//  APIRequestHandler.swift
//  Fetch Rewards Meals
//
//  Created by Luis Samayoa on 6/7/24.
//

import Foundation

class APIRequestHandler {
    static func makeRequest<T: Codable>(url: URL, expectedTypeResp: T.Type) async -> T? {
        // Attempt to fetch data
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
                        
            do {
                // Decode response into type T and return
                let response = try JSONDecoder().decode(T.self, from: data)
                print("Data successfully fetched")
                return response
            }
            
            
        // If there are any failures, print error
        } catch {
            print("Error: call \(url) failed due to \(error).")
            return nil
        }
    }
    
}
