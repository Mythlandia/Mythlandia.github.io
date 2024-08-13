//
//  Districts.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/13/24.
//


import Foundation
import Ignite

struct Districts: StaticPage {
    var title = "Districts"
    
    func body(context: PublishingContext) -> [BlockElement] {
        Spacer()
        Text("Districts")
            .font(.title2)
        for district in config.districts {
            Text(district)
                .margin(0)
                .padding(.leading,20)
        }
    }

}
