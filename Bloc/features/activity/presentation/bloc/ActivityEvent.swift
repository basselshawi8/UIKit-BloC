//
//  ActivityEvent.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation

protocol ActivityEvent:BaseEvent {
 
}

class GetActivityEvent:ActivityEvent {
    static func == (lhs: GetActivityEvent, rhs: GetActivityEvent) -> Bool {
        return lhs._param == rhs._param
    }
    
    let _param:GetActivityParam
     init(param:GetActivityParam) {
        
        _param = param
    }
}
