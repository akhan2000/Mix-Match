//
//  NoUserView.swift
//  MixMatch
//
//  Created by Christian Garvin on 4/24/23.
//

import SwiftUI

struct noCurrentUser:View{
    @EnvironmentObject var dataStore: DataStore
    @State var isPresentingSignInForm: Bool = false
    @State var isPresentingNewAccountForm: Bool = false
    @Binding var user: User?
    
    var body: some View{
        NavigationStack{
            Button(action: {
                isPresentingSignInForm.toggle()
            }){
                HStack{
                    Text("Sign In").font(.title)
                    Image(systemName: "person.circle").font(.title)
                }
            }
            Button(action: {
                isPresentingNewAccountForm.toggle()
                
            }){
                HStack{
                    Text("Create an Account").font(.title).padding(.top, 50)
                    Image(systemName: "person.badge.plus").font(.title).padding(.top, 50)
                }
            }
            .sheet(isPresented: $isPresentingSignInForm){
                NavigationStack{
                    SignInForm(isPresented: $isPresentingSignInForm, user: $user)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Cancel") {
                                    isPresentingSignInForm = false
                                }
                            }
                            
                        }
                }
            }
            .sheet(isPresented: $isPresentingNewAccountForm){
                NavigationStack{
                    NewAccountForm(isPresented: $isPresentingNewAccountForm, user: $user)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Cancel") {
                                    isPresentingNewAccountForm = false
                                }
                            }
                            
                        }
                }
            }
        }
    }
}
