//
//  ModelData.swift
//  Landmarks
//
//  Created by Teddy Rogers on 12/11/2022.
//

import Foundation
import Combine
import SwiftUI

extension String: Error {}

final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    
    @Published var profile = ProfileModel(
        id: "123242FZEFZ",
        username: "TeddRod",
        prefersNotifications: true,
        goalDate: Date(),
        seasonalPhoto: ProfileModel.Season.summer
    )
    
    var hikes: [Hike] = load("hikeData.json")
    
    var featured: [Landmark] {
        landmarks.filter{$0.isFeatured}
    }
    
    var categories: [String: [Landmark]] {
        Dictionary(grouping: landmarks, by: {$0.category.rawValue})
    }
}

func load <T: Decodable>(_ filename: String) -> T {
    let file = Bundle.main.url(forResource: filename, withExtension: nil)
    
    do {
        let data = try? Data(contentsOf: file!)
        return try JSONDecoder().decode(T.self, from: data!)
    } catch{
        fatalError("Could not parse \(filename) as \(T.self):\n\(error)")
    }
}

func sendProfile<T: Decodable>(profile: ProfileModel) async throws -> T {
    let encoded = try? JSONEncoder().encode(profile)
    let url = URL(string:"http://192.168.1.24:8000/test")!
    
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "content-type")
    request.httpMethod = "post"
    
    do {
        let (data, _) = try await URLSession.shared.upload(for:request, from: encoded! )
        return try JSONDecoder().decode(T.self,from: data)
    } catch {
        fatalError("Send profile fails.")
       
    }
}
