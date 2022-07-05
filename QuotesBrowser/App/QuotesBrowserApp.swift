//
//  QuotesBrowserApp.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 17.06.22.
//

import SwiftUI

@main
struct QuotesBrowserApp: App {
    var body: some Scene {
        WindowGroup {
          InitialView()
                .environmentObject(ViewModelFactory())
        }
    }
}
