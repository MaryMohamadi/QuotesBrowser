//
//  ValidatoreRules.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 20.06.22.
//
import Foundation
struct ValidatorRule: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let message: String

    static let emailEmpty: ValidatorRule = ValidatorRule(name: "emailEmpty",
                                                         message: "Email should not be empty")
    static let emailInvalid: ValidatorRule = ValidatorRule(name: "email",
                                                           message: "Email not valid")
    static let usernameEmpty: ValidatorRule = ValidatorRule(name: "username",
                                                             message: "Username should not be empty")
    static let passwordEmpty: ValidatorRule = ValidatorRule(name: "password",
                                                            message: "Password should not be empty")
    static let passwordWrong: ValidatorRule = ValidatorRule(name: "passwordWrong",
                                                            message: "Password is wrong")
}
