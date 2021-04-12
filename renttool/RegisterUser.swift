//
//  RegisterUser.swift
//  renttool
//
//  Created by Ismatulla Mansurov on 4/12/21.
//

import SwiftUI
import Firebase

struct RegisterUser: View {
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
                Text("Register")
                    .onTapGesture(perform: {
                        self.login()
                    })
                }

                    
                    }
                }
            }
        


func login() {
    Auth.auth().createUser(withEmail: email, password: password)  {  (result, error) in
          if error != nil {
              print(error?.localizedDescription ?? "")
          } else {
           print("success")
            shouldTransit = true
            
            
        }
      }   }
}
      

struct RegisterUser_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUser()
    }
}
