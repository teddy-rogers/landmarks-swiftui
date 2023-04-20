//
//  conf.swift
//  Landmarks
//
//  Created by Teddy Rogers on 17/11/2022.
//

import Foundation

enum API {
    static var secretKey: String {
        return Bundle.main.object(forInfoDictionaryKey:"SECRET_KEY") as! String
    }
}
