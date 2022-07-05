//
//  ServiceManager.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 18.06.22.
//

import Foundation
import Combine
protocol NetworkManager {
    func sendRquest<T, U>(httpMethod: String?,
                          endpoint: Endpoint,
                          decodingType: T.Type,
                          params: U?) -> AnyPublisher<T, NetworkError> where T: Codable, U: Codable
}

protocol RequestBuilder {
    func createRequest<T: Codable>(httpMethod: String? , params: T?) -> URLRequest
}

extension NetworkManager {
    
    func sendRquest<T, U>(httpMethod: String? = HTTPMethod.get.rawValue,
                          endpoint: Endpoint,
                          decodingType: T.Type,
                          params: U? = Optional<LoginModel>.none) -> AnyPublisher<T, NetworkError> where T: Codable, U: Codable {
        let decoder = JSONDecoder()
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let urlRequest = endpoint.createRequest(httpMethod: httpMethod, params: params)
        return session.dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response ->  T in
                if let response = response as? HTTPURLResponse {
                    guard response.statusCode == 200 else {
                        let error = NetworkError.httpError(response.statusCode)
                        throw error
                    }
                    let model = try decoder.decode(T.self, from: data)
                    return model
                }
                
                throw NetworkError.unknown
            }
            .mapError { error  in
                NetworkError.networkError(error)
            }
            .eraseToAnyPublisher()
    }
}


enum Authentication {
    static let AppToken = "Token token=a7b671c319ceb09d9aed93dee85ba26e"
}

