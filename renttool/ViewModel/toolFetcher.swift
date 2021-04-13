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

    init(id: String, name: String, price: Int) {
        toolID = id
        toolName = name
        toolPrice = price
    }
}
