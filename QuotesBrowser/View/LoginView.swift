//
//  LoginView.swift
//  QuotesBrowser
//
//  Created by Maryam Alimohammadi on 19.06.22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Username")
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            HStack {
                Text("Password")
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                    
            }
            .padding()
            /// preview when  signup
            if viewModel.currentView == .signUp {
                HStack {
                    Text("Email")
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
            }
            Button(viewModel.currentView.rawValue, action: {
                switch viewModel.currentView {
                case .signIn:
                    viewModel.sendLogin()
                case .signUp:
                    viewModel.sendSignup()
                }
            })
            .buttonStyle(.borderedProminent)
            /// error view
            VStack(alignment: .trailing) {
                if !((viewModel.currentView == .signIn) && (viewModel.brokenRules.last?.name ?? "" == ValidatorRule.emailEmpty.name)) {
                    
                    ForEach(viewModel.brokenRules) { message in
                        
                        Text(message.message)
                            .multilineTextAlignment(.trailing)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
            .padding()
            Spacer()
            Button(viewModel.currentView == .signIn ? LoginViewTypes.signUp.rawValue : LoginViewTypes.signIn.rawValue,
                   action: {
                viewModel.currentView = viewModel.currentView == .signIn ? LoginViewTypes.signUp : LoginViewTypes.signIn
            })
        }
        .padding()
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static let factory: ViewModelFactory = ViewModelFactory()
    static var previews: some View {
        LoginView(viewModel: factory.makeLoginViewModel())
    }
}
