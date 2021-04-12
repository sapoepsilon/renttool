//
//  ContentView.swift
//  renttool
//
//  Created by Ismatulla Mansurov on 4/10/21.
//

import SwiftUI
import Firebase


struct FirebaseLoginApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State var email = ""
    @State var password = ""
    @State private var shouldTransit: Bool = false
        var body: some View {
            NavigationView {
               VStack {
                    
                    TextField("Email", text: $email)
                    
                SecureField("Password", text: $password)
                    
                NavigationLink(
                destination: SignUp(),
                isActive: $shouldTransit) {
                Text("Signin")
                    .onTapGesture(perform: {
                        self.login()
                    })
                }.background(Color.orange)
                .foregroundColor(Color.white)

                
                NavigationLink(
                    destination: RegisterUser(),
                    label: {
                        Text("Do not have an account? Sign Up")
                    })

                    }
                }
            }
        

func login() {
      Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
          if error != nil {
              print(error?.localizedDescription ?? "")
        
          } else {
           print("success")
            shouldTransit = true
        }
      }   }
}
      
  

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
        ContentView()
        }
    }

