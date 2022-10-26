//
//  ActivityState.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation

class ActivityState : BaseState {
    
    static func == (lhs: ActivityState, rhs: ActivityState) -> Bool {
        return true
    }
}

class InitialActivityState:ActivityState{
    static func == (lhs: InitialActivityState, rhs: InitialActivityState) -> Bool {
        return true
    }
}



class GetActivityWaitingState:ActivityState {
    
    static func == (lhs: GetActivityWaitingState, rhs: GetActivityWaitingState) -> Bool {
        return true
    }
    
    
}

class GetActivityFailureState:ActivityState {
    
    static func == (lhs: GetActivityFailureState, rhs: GetActivityFailureState) -> Bool {
        return lhs.error.localizedDescription == rhs.error.localizedDescription
    }
    
    let error:Error
    
    init (error:Error) {
        self.error = error
    }
}

class GetActivitySuccessState:ActivityState {
    static func == (lhs: GetActivitySuccessState, rhs: GetActivitySuccessState) -> Bool {
        return lhs.model == rhs.model
    }
    
    let model:ActivityModel
    
    init(model:ActivityModel) {
        self.model = model
    }
}
