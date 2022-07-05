//
//  ListModel.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 18.06.22.
//

import Foundation
struct ResultModel: Codable {
    var page: Int
    var lastPage: Bool
    var quotes: [QuoteModel]
    
    private  enum CodingKeys: String, CodingKey {
        case page
        case lastPage = "last_page"
        case quotes
    }
    
}
