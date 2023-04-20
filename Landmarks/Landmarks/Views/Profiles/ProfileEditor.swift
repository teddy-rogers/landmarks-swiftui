//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by Teddy Rogers on 16/11/2022.
//

import SwiftUI

struct ProfileEditor: View {
    @AppStorage("colorSet") var color = "blue"
    
    @Binding var profile: ProfileModel
    var secret: String
    
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }
    
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username", text: $profile.username)
            }
            
            HStack {
                Text("Color").bold()
                Divider()
                TextField("Color", text: $color)
            }
            
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications").bold()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Seasonal Photo").bold()
                Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
                    ForEach(ProfileModel.Season.allCases) { season in
                        Text(season.rawValue).tag(season)
                    }
                }.pickerStyle(.segmented)
                
            }
            
            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date) {
                Text("Goal Date").bold()
            }
            
            HStack{
                Text("Secret Key").bold()
                Divider()
                Text(secret)
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default), secret: "yo!")
    }
}
