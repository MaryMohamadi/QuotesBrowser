//
//  QuotesMainView.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 18.06.22.
//

import SwiftUI

struct QuotesMainView: View {
    @Namespace var nameSpace
    @EnvironmentObject var vmFactory: ViewModelFactory
    @ObservedObject var quotesViewModel: QuotesMainViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    @State private var showLoginModal: Bool = true
    @State private var showDetailView: Bool = false
    @State private var selectedItem: QuoteModel?
    @State private var scrollInvdex = 0
    private let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            ScrollView {
                ScrollViewReader { value in
                    ///  custom collection
                    LazyVGrid(columns: gridItemLayout, spacing: 8) {
                        ForEach(quotesViewModel.searchResults, id: \.id) { quote in
                            QuoteCell(model: quote,
                                      searchText: $quotesViewModel.searchText,
                                      isTagSelected: $quotesViewModel.isTagSelected)
                            .matchedGeometryEffect(id: quote.id,
                                                   in: nameSpace)
                            
                            .onAppear {
                                quotesViewModel.loadMoreContent(currentItem: quote)
                            }
                            .onTapGesture {
                                scrollInvdex = quotesViewModel.searchResults.firstIndex(where: { $0 == quote }) ?? 0
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    selectedItem = quote
                                }
                            }
                            ///  using  matchedGeometryEffect for implementing custon navigation
                        }
                    }
                    .onAppear {
                        value.scrollTo(scrollInvdex)
                    }
                }
                
            }
            if selectedItem != nil {
                //Mark: - cell content view
                ///  for implementing custon navigation
                ForEach(quotesViewModel.quoteList, id: \.id
                ) { quote in
                    if quote == selectedItem {
                        QuotesDetailView(selectedItem: $selectedItem,
                                         searchText: $quotesViewModel.searchText)
                        ///  using  matchedGeometryEffect for implementing custon navigation
                        .matchedGeometryEffect(id: quote.id,
                                               in: nameSpace)
                        
                    }
                }
                .ignoresSafeArea()
                .navigationBarHidden(true)
            }
        }
        .onReceive(quotesViewModel.$quoteList, perform: { value in
            /// for showing random quot when user open the app
            if quotesViewModel.page == 1 && value.count > 0 {
                let random = Int.random(in: 0..<value.count)
                selectedItem = value[random]
            }
        })
        .onReceive(loginViewModel.$isNotAuthenticated, perform: { value in
            /// load data immidiately after signup or login
            if !value && quotesViewModel.quoteList.count == 0 {
                selectedItem = nil
                quotesViewModel.getQuoteList(page: 1)
            }
        })
    }
}

struct QuotesMainView_Previews: PreviewProvider {
    static let factory: ViewModelFactory = ViewModelFactory()
    static var previews: some View {
        QuotesMainView(quotesViewModel: factory.makeQuotesMainViewModel(),
                       loginViewModel: factory.makeLoginViewModel())
    }
}
