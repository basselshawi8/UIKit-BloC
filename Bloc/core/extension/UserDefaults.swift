//
//  UserDefaults.swift
//  Bloc
//
//  Created by iMac on 10/26/22.
//

import Foundation

extension UserDefaults {
    
    @UserDefault(key: "year_of_birth")
    static var yearOfBirth: Int?
    
    @UserDefault(key: "user_name",defaultValue: "")
    static var name: String
}
