//
//  File.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/10/24.
//

import Foundation
import Ignite

struct Villages: StaticPage {
    let title = "The Villages"
    
    func body(context: PublishingContext) -> [BlockElement] {
        
        Text("A List of Villages")
        List {
            for village in config.villages {
                Text(village)
            }
        }
    }
    
}
