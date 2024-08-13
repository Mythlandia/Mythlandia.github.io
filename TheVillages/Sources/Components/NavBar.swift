//
//  NavBar.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/10/24.
//


import Foundation
import Ignite

/// An example navigation bar, demonstrating how to create reusable components.
struct NavBar: Component {
    func body(context: PublishingContext) -> [any PageElement] {
        NavigationBar(
            logo: Text("The Villages Primer")
                .font(.title1)
                .foregroundStyle(Color.darkGreen)
                .padding()
        ) {
            Dropdown("Key concepts") {
                Link("Villages", target: Villages() )
                Link("Locations", target: Locations() )
            }
        }
        .navigationItemAlignment(.trailing)
        .background(Color.lightGreen)
        .position(.fixedTop)
        .navigationItemAlignment(.trailing)
        
        Spacer(size: 50)
    }
}
