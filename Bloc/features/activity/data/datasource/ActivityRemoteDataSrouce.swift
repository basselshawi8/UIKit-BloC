//
//  ActivityRemoteDataSrouce.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation
import Combine
import Alamofire

class ActivityRemoteDataSource: ActivityDataSrouce {
    
    
    func getActivity(params: GetActivityParam) -> Future<ActivityModel, Error> {
        return APIService.shared.apiRequest(converter: ActivityModel.self, url: "https://www.boredapi.com/api/activity", method: HTTPMethod.get, parameter: params.jsonObject, encoder: URLEncoding.default, headers: NO_AUTHORIZATION_HEADER())
    }
}
