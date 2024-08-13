//
//  Locations.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/10/24.
//

import Foundation
import Ignite

struct Locations: StaticPage {
    var title = "Locations"
    
    func body(context: PublishingContext) -> [BlockElement] {
        Spacer()
        Text("Locations")
        for location in config.locations {
            Text(location)
                .margin(0)
                .padding(.leading,20)
        }
    }

}
