//
//  AddTool.swift
//  renttool
//
//  Created by Ismatulla Mansurov on 4/12/21.
//

import SwiftUI
import Firebase
import Photos
import UIKit

struct AddTool: View {
    @State var toolName = ""
    @State var toolDescription = ""
    @State var toolPrice = ""
    @State var toolAddress = ""
    @State var payMethod = ""
    @State private var shouldTransit: Bool = false
    let db = Firestore.firestore()
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var isUseCamera = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                
                
                TextField("Tool name", text: $toolName)
                TextField("Tool Description", text: $toolDescription)
                TextField("Tool Price in USD", text: $toolPrice)
                TextField("Tool Addresss", text: $toolAddress)
                TextField("Method of pay", text: $payMethod)
                
                
                NavigationLink(
                    destination: AccountPage(),
                    isActive: $shouldTransit){
                    Text("Add the tool")
                        .onTapGesture(perform: {
                            self.addTool()
                        })
                }
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                HStack{
                    Button(action: {
                        self.isShowPhotoLibrary = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                                .font(.system(size: 20))
                            Text("Photo library")
                                .font(.headline)
                        } .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 50)
                    }.background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.horizontal)

                }
            }.sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
    
    
    func addTool() {
        let userID = Auth.auth().currentUser?.uid
        var photoURL = ""
        var ref: DocumentReference? = nil
        
        ref = db.collection("tools").addDocument(data: [
                                            
                "toolName" : toolName,
                "toolDescription" : toolDescription,
                "toolPrice" : toolPrice,
                "toolAddress" : toolAddress,
                "payMethod" : payMethod,
                "userID" : userID! ]) {
            err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                shouldTransit = true
                var data = NSData()
                data = image.jpegData(compressionQuality: 0.8)! as NSData
                var storageRef = Storage.storage().reference()
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                storageRef = Storage.storage().reference()
                let photoRef = storageRef.child(data.description)
                let toolID = ref!.documentID
                photoRef.putData(data as Data, metadata: metaData){(metaData,error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }else{
                        //store downloadURL

                        photoRef.downloadURL { (url, error) in
                            guard url != nil
                             else {
                              print("Uh-oh, an error occurred!")
                              
                                return
                            }
                            db.collection("tools").document(toolID).setData(["PhotoURL" : url!.absoluteString ], merge: true){ err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                }
                            }
                            print(url!.absoluteString)
                           
                    }
                }
            }
                
                let userRef = db.collection("users").document(userID!)
                userRef.updateData(["toolID" : FieldValue.arrayUnion([toolID]) ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Tool successfully updated")
                        
                        
                   
                    }
                }
           
        }
    }
}



struct AddTool_Previews: PreviewProvider {
    static var previews: some View {
        AddTool()
    }
}

}
