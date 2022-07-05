//
//  SignupModel.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 20.06.22.
//

import Foundation
import Foundation
struct SignupDetailModel: Codable {
    var login: String
    var password: String
    var mail: String
    
    init(login: String, password: String, mail: String) {
        self.login = login
        self.password = password
        self.mail = mail
    }
    
}

struct SignupModel: Codable {
    var user: SignupDetailModel
    
    init(user: SignupDetailModel) {
        self.user = user
    }
    
}

extension SignupModel {
    public static var addSignup: SignupModel = SignupModel(user: SignupDetailModel(login: "login",
                                                                               password: "password",
                                                                               mail: "mail"))
}
