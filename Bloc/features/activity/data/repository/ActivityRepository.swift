//
//  ActivityRepository.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation
import Combine

class ActivityRespository {
    let datasrouce:ActivityDataSrouce
    
    init(_datasrouce:ActivityDataSrouce) {
        self.datasrouce=_datasrouce
    }
    
    func getActivity(params:GetActivityParam)->Future<ActivityModel,Error> {
        return datasrouce.getActivity(params: params)
        
    }
}
