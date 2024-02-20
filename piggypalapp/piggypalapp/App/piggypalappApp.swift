//
//  piggypalappApp.swift
//  piggypalapp
//
//  Created by Rithmika Naveen on 2/12/24.
//

import SwiftUI
import Firebase

@main
struct piggypalappApp: App {
    @StateObject var viewModel = AuthViewModel()
    class AppDelegate: UIResponder, UIApplicationDelegate {
    }
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
