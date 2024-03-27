//
//  SignInForm.swift
//  MixMatch

import SwiftUI

struct SignInForm: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginFailed: Bool = false
    @State private var failureMessage: String = ""
    @Binding var isPresented: Bool
    @Binding var user: User?
    
    var body: some View {
        Form {
            Section(header: Text("Sign In")
                .foregroundColor(.black).font(.title2)) {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            
            Section {
                Button(action: {
                    dataStore.signInUser(username.trimmingCharacters(in: .whitespacesAndNewlines))
                    user = dataStore.getCurrentUser()
                    if user == nil {
                        isLoginFailed.toggle()
                        failureMessage = "Incorrect username or password"
                    } else {
                        isPresented.toggle()
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Sign In")
                        Spacer()
                    }
                }.disabled(username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .alert(isPresented: $isLoginFailed) {
            Alert(title: Text("Login Failed"),
                  message: Text(failureMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}
