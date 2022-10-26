//
//  APIService.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation
import Alamofire
import Combine

class APIService{
    
    static let shared = APIService()
    
    private init(){}
    
    func apiRequest<T : Decodable>(converter:T.Type,url:String,method:HTTPMethod,parameter:Parameters?,encoder:ParameterEncoding,headers:HTTPHeaders?)->Future<T,Error> {
        return Future<T,Error> { promise in
            let request = AF.request(url, method: method, parameters: parameter, encoding: encoder, headers: headers, interceptor: nil, requestModifier: nil)
            request.validate()
            request.responseDecodable(of: T.self) { (response) in
                            switch response.result{
                            case .failure(let Lerror):
                                promise(.failure(Lerror))
                                break
                            case .success(let dataObj):
                                promise(.success(dataObj))
                                break
                            }
                            
                        }
        }
    }
        
}

