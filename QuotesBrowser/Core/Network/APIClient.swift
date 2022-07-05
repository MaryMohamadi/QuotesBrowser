//
//  ClientAPI.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 21.06.22.
//

import Foundation
import Combine

final class APIClient:  NetworkManager {
    
    func sendLogin(username: String, password: String) -> AnyPublisher<LoginResponseModel, NetworkError> {
        return sendRquest(httpMethod: HTTPMethod.post.rawValue,
                          endpoint: .session ,
                          decodingType: LoginResponseModel.self,
                          params: LoginModel(user:LoginDetailModel(login: username, password: password)))
    }
    
    func sendSignup(username: String, password: String, mail: String) -> AnyPublisher<SignupResponseModel, NetworkError> {
        return sendRquest(httpMethod: HTTPMethod.post.rawValue,
                          endpoint: .signup ,
                          decodingType: SignupResponseModel.self,
                          params: SignupModel(user:SignupDetailModel(login: username, password: password, mail: mail)))
    }
    
    
    func getQuoteList(page: Int) -> AnyPublisher<ResultModel, NetworkError> {
            return sendRquest(endpoint: .quoteslist(page),
                              decodingType: ResultModel.self)

    }
}

