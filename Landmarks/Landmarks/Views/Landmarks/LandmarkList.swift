//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Teddy Rogers on 12/11/2022.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly||landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView{
            List {
                Toggle(isOn: $showFavoritesOnly){
                    Text("Favorite only")
                }

                ForEach(filteredLandmarks) {landmark in
                    NavigationLink {
                        LandmarkDetails(landmark: landmark)
                    } label : {
                        LandmarkRow(landmark: landmark)
                    }
                }
                
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
    }
}
