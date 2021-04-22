//
//  TooldViewModel.swift
//  renttool
//
//  Created by Juan Jimenez on 4/20/21.
//

import Foundation
import FirebaseFirestore

class ToolsViewModel : ObservableObject {
    
    @Published var tool = [tools]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        
        db.collection("tools").addSnapshotListener {(querySnapshot, error ) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            documents.map{(queryDocumentSnapshot) -> tools in
                let data = queryDocumentSnapshot.data()
                let toolID = data ["toolID"] as? String ?? ""
                let toolN = data["toolName"] as? String ?? ""
                let toolP = data["toolPrice"] as? Int ?? 0
                let toolU = data["photoURL"] as? String ?? ""
                return tools(id: toolID , name: toolN, price: toolP, url: toolU)
                
            }
            
        }
        
        
        
    }
    
}
