//
//  Endpoint.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 21.06.22.
//

import Foundation
import Combine

enum Endpoint {
    case baseURL
    case quoteslist(Int)
    case login
    case signup
    case session
    var discription: String {
        switch self {
        case .baseURL:
            return "https://favqs.com/api/"
        case .quoteslist(let page):
            return  page == 1 ? "quotes" : "quotes?=\(page)"
            
        case .login:
            return "login"
        
        case .signup:
            return "users"
            
        case .session:
            return "session"

        }
    }
    var url: String {
        return Endpoint.baseURL.discription+self.discription
    }
}

extension Endpoint: RequestBuilder {
    func createRequest<T: Codable>(httpMethod: String?, params: T?) -> URLRequest {
        let defaults = UserDefaults.standard
        var urlRequest = self.urlRequest
        let encoder = JSONEncoder()
        urlRequest.httpMethod = httpMethod
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token: String = defaults.value(forKey: "app_token") as? String {
            urlRequest.setValue(Authentication.AppToken, forHTTPHeaderField: "Authorization")
            urlRequest.setValue("Token token=\(token)", forHTTPHeaderField: "User-Token")
        } else {
            /// for authentication when there is no stored user token
            urlRequest.setValue(Authentication.AppToken, forHTTPHeaderField: "Authorization")
            do {
                let jsonData = try encoder.encode(params)
                urlRequest.httpBody = jsonData
                print("jsonData: ", String(data: urlRequest.httpBody!, encoding: .utf8) ?? "no body data")
            } catch {
                print(String(describing: error))
            }
        }
        return urlRequest
    }
    
    private var urlRequest: URLRequest {
        guard let url = URL(string: self.url) else {
            preconditionFailure(NetworkError.invalidURL.localizedDescription)
        }
        
        return URLRequest(url: url)
    }
}
