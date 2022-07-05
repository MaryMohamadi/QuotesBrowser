//
//  LoginModel.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 19.06.22.
//

import Foundation
struct LoginDetailModel: Codable {
    var login: String
    var password: String
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
}

struct LoginModel: Codable {
    var user: LoginDetailModel
    
    init(user: LoginDetailModel) {
        self.user = user
    }
    
}

extension LoginModel {
    public static var addLogin: LoginModel = LoginModel(user: LoginDetailModel(login: "login",
                                                                               password: "password"))
}
