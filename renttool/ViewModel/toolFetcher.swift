//
//  toolFetcher.swift
//  renttool
//
//  Created by Ismatulla Mansurov on 4/13/21.
//

import Foundation

class toolObject: ObservableObject {
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
