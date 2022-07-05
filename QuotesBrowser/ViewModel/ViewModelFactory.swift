//
//  ViewModelFactory.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 21.06.22.
//

import Foundation
class ViewModelFactory: ObservableObject {
    private var client: APIClient = APIClient()
    
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(client: client)
    }
    
    func makeQuotesMainViewModel() -> QuotesMainViewModel {
        return QuotesMainViewModel(client: client)
    }
}
