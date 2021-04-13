//
//  RegisterUser.swift
//  renttool
//
//  Created by Ismatulla Mansurov on 4/12/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct RegisterUser: View {
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var lastName = ""
    @State var phoneNumber = ""
    @State private var shouldTransit: Bool = false
    let db = Firestore.firestore()
        var body: some View {
            NavigationView {
               VStack {
                

                    
                TextField("Email", text: $email)

                SecureField("Password", text: $password)
                TextField("Name", text: $name)
                TextField("lastName", text: $lastName)
                TextField("PhoneNumber", text: $phoneNumber)

                    
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
            let User = Auth.auth().currentUser?.uid
            let firstName = String(name)
            let lastName1 = String(lastName)
            let phoneNumeber1 = Int(phoneNumber)
            
           print("success")
            shouldTransit = true
            db.collection("users").document(User!).setData([
                "name" : firstName,
                "lastName" : lastName1,
                "phoneNumber" : phoneNumeber1 ]) {
                err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            
        }
      }   }
}
      

struct RegisterUser_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUser()
    }
}
