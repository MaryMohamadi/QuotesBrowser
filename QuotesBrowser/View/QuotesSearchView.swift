//
//  QuotesSearchView.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 23.06.22.
//

import SwiftUI

struct QuotesSearchView: View {
    @EnvironmentObject var vmFactory: ViewModelFactory
    @ObservedObject var quotesViewModel: QuotesMainViewModel
    @ObservedObject var loginViewModel: LoginViewModel

    var body: some View {
        NavigationView {
            ZStack {
                QuotesMainView(quotesViewModel: quotesViewModel,
                               loginViewModel: loginViewModel)
                .navigationTitle("Quots")
                
            }
        }
        .searchable(text: $quotesViewModel.searchText,
                     placement: .navigationBarDrawer(displayMode: .always))
        .onAppear{
            /// load data
            quotesViewModel.getQuoteList()
        }
        ///  preview login view if user token is not stored
        .fullScreenCover(isPresented: $loginViewModel.isNotAuthenticated) {
            LoginView(viewModel: loginViewModel)
        }
        
    }
}

struct QuotesSearchView_Previews: PreviewProvider {
    static let factory: ViewModelFactory = ViewModelFactory()
    static var previews: some View {
        QuotesSearchView(quotesViewModel: factory.makeQuotesMainViewModel(),
                         loginViewModel: factory.makeLoginViewModel())
    }
}
