//
//  ActivityDataSrouce.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation
import Combine

protocol ActivityDataSrouce  {
    
    func getActivity(params:GetActivityParam)->Future<ActivityModel,Error>
}
