//
//  LoginView.swift
//  StudentListApp
//
//  Created by Seteven on 11/01/25.
//
import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var loginFailed = false
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                VStack(spacing: 8) {
                    Text("Welcome Back")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("Please sign in to continue")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20)
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Username")
                            .font(.callout)
                            .foregroundColor(.gray)
                        
                        TextField("", text: $username)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                            .keyboardType(.default)
                            .autocapitalization(.none)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.callout)
                            .foregroundColor(.gray)
                        
                        SecureField("", text: $password)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            )
                    }
                }
                
                Button(action: {
                    withAnimation {
                        isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            if username == "alfagift-admin" && password == "asdf" {
                                isLoggedIn = true
                                loginFailed = false
                            } else {
                                loginFailed = true
                            }
                            isLoading = false
                        }
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black)
                            .frame(height: 56)
                        
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Sign In")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }
                .disabled(isLoading)
                
                if loginFailed {
                    Text("Invalid username or password")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)
            .background(
                Color.white
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.08), radius: 15, x: 0, y: 5)
            )
            .padding()
        }
    }
}
