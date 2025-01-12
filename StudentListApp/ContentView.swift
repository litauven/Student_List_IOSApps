//
//  ContentView.swift
//  StudentListApp
//
//  Created by Seteven on 11/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            StudentListView()  
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

