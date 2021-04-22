//
//  Tools.swift
//  renttool
//
//  Created by Juan Jimenez on 4/20/21.
//

import Foundation

class tools: Identifiable {
    @Published var toolID: String
    @Published var toolName: String
    @Published var toolPrice: Int
    @Published var photoURL: String


    init(id: String, name: String, price: Int, url: String) {
        toolID = id
        toolName = name
        toolPrice = price
        photoURL = url
    }
}
