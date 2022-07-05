//
//  SignupResponse.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 20.06.22.
//

import Foundation
import Foundation
struct SignupResponseModel: Codable {
    var userToken: String
    var login: String
    private enum CodingKeys: String, CodingKey {
        case userToken = "User-Token"
        case login
    }
}
