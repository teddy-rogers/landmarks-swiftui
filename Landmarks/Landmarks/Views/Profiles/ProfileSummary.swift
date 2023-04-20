//
//  ProfileSummary.swift
//  Landmarks
//
//  Created by Teddy Rogers on 16/11/2022.
//

import SwiftUI

struct ProfileSummary: View {
    @AppStorage("colorSet") var color = ""
    @EnvironmentObject var modelData: ModelData
    @State private var test: String = ""
    
    var profile: ProfileModel
    
    let languagePrefix: String = Locale.preferredLanguages[0] as String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing:  10) {
                Text(profile.username)
                    .bold()
                    .font(.title)
                Text("Notifications: \(profile.prefersNotifications ? "On" : "off")")
                Text("Seasonal photo: \(profile.seasonalPhoto.rawValue)")
                Text("Goal date: ") + Text(profile.goalDate, style: .date)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Completed Badges")
                        .font(.headline)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            HikeBadge(name: "First Hike")
                            HikeBadge(name: "Earth Day")
                                .hueRotation(Angle(degrees: 90))
                            HikeBadge(name: "Tenth Hike")
                                .grayscale(0.5)
                                .hueRotation(Angle(degrees: 45))
                        }
                        .padding(.bottom)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Recent Hikes")
                        .font(.headline)
                    
                    HikeView(hike: modelData.hikes[0])
                }
                
                Button("Send profile") {
                    Task {
                        test = try await sendProfile(profile:profile)
                    }
                }
                
                HStack {
                    Text(languagePrefix)
                    Text(test)
                    Text(color)
                }
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: ModelData().profile)
            .environmentObject(ModelData())
    }
}
