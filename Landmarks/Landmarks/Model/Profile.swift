//
//  Profile.swift
//  Landmarks
//
//  Created by Teddy Rogers on 15/11/2022.
//

import Foundation

struct ProfileModel: Hashable, Codable, Identifiable {
    var id: String
    var username: String
    var prefersNotifications :Bool
    var goalDate : Date
    var seasonalPhoto : Season
    
    static let `default` = ProfileModel(
        id: "",
        username: "",
        prefersNotifications: false,
        goalDate: Date(),
        seasonalPhoto: ProfileModel.Season.winter
    )
    
    enum Season: String, CaseIterable, Identifiable, Codable {
        var id: String {rawValue}
        case winter = "❄️"
        case spring = "🌸"
        case summer = "🌞"
        case autumn = "🍂"
    }
    
    init(id:String, username:String, prefersNotifications:Bool, goalDate: Date, seasonalPhoto: Season) {
        self.id = id
        self.username = username
        self.prefersNotifications = prefersNotifications
        self.goalDate = goalDate
        self.seasonalPhoto = seasonalPhoto
    }
}
