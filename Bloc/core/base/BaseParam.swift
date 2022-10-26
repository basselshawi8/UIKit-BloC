//
//  BaseParam.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation

protocol BaseParam : Equatable{
    
    var jsonObject : Dictionary<String,Any>{get}
}
