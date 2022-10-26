//
//  ServiceLocator.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation


class ServiceLocator {
    
    static private let _shared = ServiceLocator()
    
    private init(){
        
        addService(service: ActivityRemoteDataSource())
        let activiyDataSrouce : ActivityRemoteDataSource? = getService()
        if let _activiyDataSrouce = activiyDataSrouce {
            addService(service: ActivityRespository(_datasrouce: _activiyDataSrouce))
        }
        addService(service: ActivityBloc())
    }
    

    static var shared:ServiceLocator {
        get {
            return _shared
        }
    }
    
    private lazy var reg: [String: AnyObject] = [:]
    func addService<T>(service: T) {
        let key = "\(type(of: service))"
        reg[key] = service as AnyObject
    }
    
    func getService<T>() -> T? {
        let key = "\(T.self)"
        return reg[key] as? T
    }
    
}
