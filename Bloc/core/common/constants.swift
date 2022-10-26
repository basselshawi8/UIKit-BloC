//
//  constants.swift
//  Bloc
//
//  Created by iMac on 10/22/22.
//

import Foundation
import Alamofire

let serverURL = "http://champsahead.arenasystem.co/"
let apiURL = serverURL + "/Api/"

let APIKEY = "A+dat4F)mwFaUU,38]Z5BvAySR(y/xJ#@m9Wt5_wUZRrmB*T>jD82{CppaYh!+MG"


func NO_AUTHORIZATION_HEADER() -> HTTPHeaders{
    return ["APIKEY": APIKEY,
        "Content-Type": "application/json; charset=utf-8"]
}

func AUTHORIZATION_HEADER() -> HTTPHeaders{
    let token = (UserDefaults.standard.value(forKey: USER_DEFAULTS_TOKEN_KEY) as? String) ?? ""

    return ["Authorization":"Bearer \(token)",
        "Content-Type": "application/json; charset=utf-8"]
}


let USER_DEFAULTS_TOKEN_KEY = "uesrDefaultsTokenKey"

func saveToUserDefaults(token:String) {
    
    let userDefautls = UserDefaults.standard
    userDefautls.setValue(token, forKey: USER_DEFAULTS_TOKEN_KEY)
    userDefautls.synchronize()
}

let placeHolderImage = UIImage(named: "placeHolder")

