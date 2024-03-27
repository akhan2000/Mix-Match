//
//  NewAccountForm.swift
//  MixMatch
//


import SwiftUI

struct NewAccountForm: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var username: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isCreateFailed: Bool = false
    @State private var failureMessage: String = ""
    @Binding var isPresented: Bool
    @Binding var user: User?
    
    var body: some View {
        Form {
            Section(header: Text("Create an Account")
                .foregroundColor(.black).font(.title2)) {

                    TextField("Username", text: $username)
                    TextField("Name", text: $name)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
            }
            
            Section {
                Button(action: {
                    if password != confirmPassword {
                        isCreateFailed.toggle()
                        failureMessage = "Password and confirmed password do not match"
                    } else if username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                                password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                                confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                                name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        isCreateFailed.toggle()
                        failureMessage = "Please fill in all the fields"
                    } else {
                        let newUser = User(username: username.trimmingCharacters(in: .whitespacesAndNewlines),
                                           password: password.trimmingCharacters(in: .whitespacesAndNewlines),
                                           name: name.trimmingCharacters(in: .whitespacesAndNewlines))
                        dataStore.addNewUser(newUser)
                        isPresented.toggle()
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Create Account")
                        Spacer()
                    }
                }
            }
        }
        .alert(isPresented: $isCreateFailed) {
            Alert(title: Text("Account Creation Failed"),
                  message: Text(failureMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}
