//
//  Location.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/13/24.
//

import Foundation
import Ignite

struct Location: StaticPage {
    
    var title: String
    var path: String
    
    init(title: String) {
        self.title = title
        self.path = "Locations/"+title
    }
    
    func body(context: PublishingContext) async -> [any BlockElement] {
        Spacer()
        Text(title)
            .font(.title2)
        
        let villages: [String] = {
            let uniqueVillages = Set<String>( config.table.filter { $0[3] == title }.map { $0[4] } )
            return Array(uniqueVillages).sorted()
        }()
        
        Text("Villages")
            .font(.title4)
        if villages.isEmpty {
            Text("This location has no villages")
        } else if villages.count == 1 {
            Text("This location is in \(villages[0])")
        } else {
            Text("This location contains multiple villages:")
            for village in villages {
                Text("\(village)")
                    .margin(0)
                    .padding(.leading,20)
            }
        }
        Spacer()
        Text("Streets")
            .font(.title4)
        
        let streets: [String] = {
            let uniqueStreets = Set<String>( config.table.filter { $0[3] == title }.map { $0[2] } )
            return Array(uniqueStreets).sorted()
        }()
        
        for street in streets {
            Text( street )
                .margin(0)
                .padding(.leading,20)
        }
    }
    
}
