//
//  AccountPage.swift
//  renttool
//
//  Created by Ismatulla Mansurov on 4/12/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AccountPage: View {
    
    let db = Firestore.firestore()
    @State var name = ""
    @State var lastName = ""
    @State var phoneNumber = 0
    
    var body: some View {
        VStack() {
            VStack{
                
                TextField("lastName", text: $lastName)
                    .background(Color.gray)
                    .multilineTextAlignment(.center)
              
                TextField("Name", text: $name)
                    .background(Color.gray)
                    .multilineTextAlignment(.center)
                TextField("PhoneNumber", value: $phoneNumber,formatter: NumberFormatter())
                    .background(Color.gray)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                                updateAccount()
                }){ Text("updateAccount").padding() }
                .background(Color.green)
                .foregroundColor(.white)
                
                NavigationLink(
                destination: AddTool()) {
                Text("Add a new tool")
                    .foregroundColor(Color.blue)
                  
                    
                }


                        
                
            }.frame(minWidth: 200, maxHeight: 800, alignment:
                        .topLeading)
            
           
        }.onAppear { self.fetchData() }
        .navigationTitle("Account page")
        .foregroundColor(Color.white)
    }
    
    
    func fetchData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                name = document.get("name") as! String
                lastName = document.get("lastName") as! String
                phoneNumber = document.get("phoneNumber") as! Int
                
            } else {
                print("Document does not exist")
            }
        }
    }

    func updateAccount() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let updateRef = db.collection("users").document(userID)

        // Set the "capital" field of the city 'DC'
        updateRef.updateData([
            "name": name,
            "lastName" : lastName,
            "phoneNumber" : phoneNumber
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }

}
struct AccountPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
    }
 }


