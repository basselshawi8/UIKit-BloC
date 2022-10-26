//
//  GetActiviyParam.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation

class GetActivityParam: BaseParam {
    static func == (lhs: GetActivityParam, rhs: GetActivityParam) -> Bool {
        return lhs._name == rhs._name
    }
    
    
    private let _name:String
    
    init(name:String?) {
        _name = name ?? ""
    }
    
    var jsonObject: Dictionary<String, Any> {
        get {
            return ["name":_name]
        }
    }
    
    
}
