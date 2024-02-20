//
//  ContentView.swift
//  piggypalapp
//
//  Created by Rithmika Naveen on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                ProfileView()
            } else {
                Login_view()
            }
        }
    }
}

#Preview {
    ContentView()
}


