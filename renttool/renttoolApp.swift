//
//  renttoolApp.swift
//  renttool
//
//  Created by Ismatulla Mansurov on 4/10/21.
//

import SwiftUI
import Firebase

@main
struct renttoolApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()

        }
    }
    
}


