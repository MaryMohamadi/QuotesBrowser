//
//  InitialView.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 21.06.22.
//

import SwiftUI

struct InitialView: View {
    @EnvironmentObject var vmFactory: ViewModelFactory

    var body: some View {
        QuotesSearchView(quotesViewModel: self.vmFactory.makeQuotesMainViewModel(),
                       loginViewModel: self.vmFactory.makeLoginViewModel())

    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
