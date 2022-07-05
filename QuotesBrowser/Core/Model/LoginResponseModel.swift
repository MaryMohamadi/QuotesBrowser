//
//  LoginModel.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 19.06.22.
//

import Foundation
struct LoginResponseModel: Codable {
    var userToken: String
    var login: String
    var email: String
    private enum CodingKeys: String, CodingKey {
        case userToken = "User-Token"
        case login
        case email
    }
}

