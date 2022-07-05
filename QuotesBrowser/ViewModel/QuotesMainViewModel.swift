//
//  QuotesMainViewModel.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 19.06.22.
//

import Foundation
import Combine

public class QuotesMainViewModel: ObservableObject {
    @Published var quoteList: [QuoteModel] = []
    @Published var searchText: String = ""
    @Published var isTagSelected: Bool = false
    private var client: APIClient
    private var lastPage: Bool = false
    public var page: Int = 1
    private var cancellables: [AnyCancellable]  = [AnyCancellable]()
    
    init(client: APIClient) {
        self.client = client
    }
    
    deinit {
        cancellables.forEach{ $0.cancel() }
    }
    
    var searchResults: [QuoteModel] {
        if searchText.isEmpty {
            /// no filter quotes
            return quoteList
        } else if !searchText.isEmpty && isTagSelected {
            /// selected tag filter
            isTagSelected.toggle()
            return quoteList.filter { (item) -> Bool  in
                return  item.tags.allSatisfy({ $0 == searchText })
            }
            
        } else {
            /// searched quoets
            return quoteList.filter { $0.body.contains(searchText) || $0.author.contains(searchText)}
        }
    }
    /// func for load list of load
    func getQuoteList(page: Int = 1) {
        client.getQuoteList(page: page)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    print(result)
                    break
                }
            }, receiveValue: { model in
                print(model)
                self.quoteList.append(contentsOf: model.quotes)
                self.lastPage = model.lastPage
                if page == 1 {
                    
                }
            })
            .store(in: &cancellables)
    }
    /// func for implementing paggination and loading next page
    func loadMoreContent(currentItem item: QuoteModel){
        guard !lastPage else {
            return
        }
        let thresholdIndex = self.quoteList.index(self.quoteList.endIndex, offsetBy: -1)
        if thresholdIndex == quoteList.firstIndex(of: item) {
            page += 1
            getQuoteList(page: page)
        }
    }
}
