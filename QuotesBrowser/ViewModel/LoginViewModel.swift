//
//  LoginViewModel.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 19.06.22.
//

import Foundation
import SwiftUI
import Combine

public class LoginViewModel: ObservableObject {
    @Published var isNotAuthenticated: Bool = true
    @Published  var currentView: LoginViewTypes = .signIn
    @Published var brokenRules: [ValidatorRule] = [ValidatorRule]()
    private let passwordPublisher: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    @Published var password: String = "" {
        didSet {
            self.passwordPublisher.send(self.password)
        }
    }
    private let mailPublisher: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    @Published var email: String = "" {
        didSet {
            self.mailPublisher.send(self.email)
        }
    }
    private let usernamePublisher: CurrentValueSubject<String, Never> = CurrentValueSubject<String, Never>("")
    @Published var username: String = "" {
        didSet {
            self.usernamePublisher.send(self.username)
        }
    }
    var submitAllowed: AnyPublisher<Bool, Never>
    private var client: APIClient
    private var cancellables: [AnyCancellable]  = [AnyCancellable]()
    
    init(client: APIClient) {
        self.client = client
        
        let validationPipeline = Publishers.CombineLatest3(usernamePublisher, passwordPublisher, mailPublisher)
            .map { args -> [ValidatorRule] in
                let (user, pass, mail) = args
                /// validation of login and signup
                guard !user.isEmpty else {
                    return[ValidatorRule.usernameEmpty]
                }
                if pass.isEmpty {
                    return [ValidatorRule.passwordEmpty]
                }
                if mail.isEmpty {
                    return [ValidatorRule.emailEmpty]
                }
                if !mail.isValidEmail() {
                    return [ValidatorRule.emailInvalid]
                }
                return []
            }
        submitAllowed = validationPipeline
            .map { rules in
                return rules.count < 1
            }
            .eraseToAnyPublisher()
        
        let _ =  validationPipeline
            .assign(to: \.brokenRules, on: self)
            .store(in: &cancellables)
        /// check user login status
        checkAuthentication()
    }
    
    deinit {
        cancellables.forEach{ $0.cancel() }
    }

    func sendLogin() {
        client.sendLogin(username: username, password: password)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.brokenRules.append(ValidatorRule.init(name: "Server", message: error.localizedDescription))
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
                
            }, receiveValue: { model in
                /// Store token and dismiss login view
                self.saveToken(token: model.userToken)
                self.isNotAuthenticated = false
            })
            .store(in: &cancellables)
    }
    func sendSignup() {
        client.sendSignup(username: username, password: password, mail: email)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    self.brokenRules.append(ValidatorRule.init(name: "Server", message: error.localizedDescription))
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { model in
                /// Store token and dismiss signup view
                self.saveToken(token: model.userToken)
                self.isNotAuthenticated = false
                
            })
            .store(in: &cancellables)
    }
    /// check user is logein status
    private func checkAuthentication() {
        let defaults = UserDefaults.standard
        isNotAuthenticated = defaults.value(forKey: "app_token") == nil
    }
    /// for for storing user token 
    private func saveToken(token: String) {
        let defaults = UserDefaults.standard
        defaults.setValue(token, forKey: "app_token")
    }
}

enum LoginViewTypes: String {
    case signIn = "Sign In"
    case signUp = "Sign Up"
}


