//
//  LakeSumter.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/10/24.
//


import Foundation
import Ignite

struct LakeSumter: StaticPage {
    var title = "Lake Sumter"
    
    func body(context: PublishingContext) -> [BlockElement] {
        
        Card( imageName: "/images/Lake Sumter dock.jpeg") {
            Text("Landing at Lake Sumter")
        }
        .frame(maxWidth: 1000)
        
        Card(imageName: "/images/Lake Sumter.jpeg") {
            Text("Lake Sumter")
        }
        .frame(maxWidth: 1000)
        
        List {
            Link("Villages", target: Villages())
            Link("Locations", target: Locations())
        }
    }
}
