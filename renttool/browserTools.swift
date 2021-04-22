//
//  browserTools.swift
//  renttool
//
//  Created by Juan Jimenez on 4/19/21.
//

import SwiftUI

let testData = [
    tools(id: "1", name: "SkillSaw", price: 25, url: "HTTP:/..."),
    tools(id: "2", name: "Impact", price: 7, url: "HTTP:/..."),
    tools(id: "3", name: "Hammer", price: 1, url: "HTTP:/..."),
    tools(id: "4", name: "Tape", price: 2, url: "HTTP:/..."),
    tools(id: "5", name: "Impact", price: 7, url: "HTTP:/..."),
    tools(id: "6", name: "Hammer", price: 1, url: "HTTP:/..."),
    tools(id: "7", name: "Tape", price: 2, url: "HTTP:/...")
]
struct browserTools: View {
    var data = testData
    @ObservedObject private var viewModel = ToolsViewModel()
    var body: some View {
        let columns: [GridItem] =
                 Array(repeating: .init(.flexible()), count: 2)
            ScrollView {
                LazyVGrid(columns:columns,
                          spacing:15 ){
                    ForEach(data) { item in
                    VStack(alignment:.leading) {
                        var pri = item.$toolPrice
                        let p = "Price: \(pri)  "
                        Text(item.photoURL)
                                .font(.subheadline)
                        Text(item.toolName)
                            .font(.headline)
                        Text(p)
                            .font(.subheadline)
                            
                           
                        }
                    }
            
                }
            }
        .navigationTitle("Tools")
}

struct browserTools_Previews: PreviewProvider {
    static var previews: some View {
        browserTools()
    }
}
}
