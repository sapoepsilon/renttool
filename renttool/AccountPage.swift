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
    @State var toolsUser = []
    @State var data: [toolObject] = []

    
    
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
            
            
            VStack {
                
                ForEach((self.data), id: \.self.toolID) { item in
                    HStack{
                    Text("\(item.toolName)")
                        Spacer()
                        Text("$\(+item.toolPrice)")
                        Spacer()
                        
                        RemoteImage(url: item.photoURL)
                            .frame(width:75, height:50)
                            
                    }}
                  }.onAppear {
                    self.getTools()
                  }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            
            
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
    
    func getTools() {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                toolsUser = document.get("toolID") as! Array
                print(toolsUser)
            } else {
                print("document does not exist")
            }
            
            
            for tool in toolsUser {
                db.collection("tools").document(tool as! String).getDocument{ (document, error) in
                    if let document = document, document.exists {
                        let id = document.documentID
                        let name = document.get("toolName") as! String
                        let price = document.get("toolPrice") as! String
                        let url = document.get("PhotoURL") as! String
                        self.data.append(toolObject(id: id, name: name, price: Int(price)!, url: url))
                        

                    } else {
                        print("document does not exist")
                    }
                }
                
            }
            
        }
    }
        struct AccountPage_Previews: PreviewProvider {
            static var previews: some View {
                AccountPage()
            }
        }
        
        
    }
