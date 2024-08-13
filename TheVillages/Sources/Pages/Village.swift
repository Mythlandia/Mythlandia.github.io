//
//  File.swift
//  IgniteStarter
//
//  Created by Phil Wigglesworth on 8/13/24.
//

import Foundation
import Ignite

struct Village: StaticPage {
    
    var title: String
    var path: String
    
    init(title: String) {
        self.title = title
        self.path = "Villages/"+title
    }
    
    func body(context: PublishingContext) async -> [any BlockElement] {
        Spacer()
        Text(title)
            .font(.title2)
        
        
        let county: String = {
            let row = config.table.first(where: { $0[4] == title } )
            if let row {
                return row[6]
            } else { return "Unknown" }
        }()
        Text("\(county) County")
            .font(.title4)
        
//        let locations: [String] = {
//            let uniqueLocations = Set<String>( config.table.filter { $0[4] == title }.map { $0[3] } )
//            return Array(uniqueLocations).sorted()
//        }()
        
        Text("Location")
            .font(.title4)
        let locationPrefixes: [String] = {
            let uniqueLocationPrefixes = Set<String>( config.table.filter { $0[4] == title }.map { Config.locationPrefix($0[3]) } )
            return Array(uniqueLocationPrefixes).sorted()
        }()
        
        if locationPrefixes.isEmpty {
            Text("This village is not in a location")
        } else if locationPrefixes.count == 1 {
            Text("This village is in \(locationPrefixes[0]) location")
        } else {
            Text("This village is in multiple locations:")
            for location in locationPrefixes {
                Text("\(location)")
                    .margin(0)
                    .padding(.leading,20)
            }
        }
        
        let locationSuffixes: [String] = {
            let uniqueLocationSuffixes = Set<String>(
                config
                    .table
                    .filter {
                        $0[4] == title && $0[3] != Config.locationPrefix($0[3])
                    }
                    .map {
                        Config.locationSuffix( Config.locationSuffix($0[3]) )
                    }
            )
            return Array(uniqueLocationSuffixes)

        }()
        for location in locationSuffixes {
            Section {
                Text("\(location)")
                    .margin(0)
                Text("\(config.location(location))")
                    .margin(0)
            }
            .margin(0)
            .padding(.leading,20)
        }
        Spacer()
        Text("Streets")
            .font(.title4)
        
        let streets: [String] = {
            let uniqueStreets = Set<String>( config.table.filter { $0[4] == title }.map { $0[2] } )
            return Array(uniqueStreets).sorted()
        }()
        
        for street in streets {
            Text( street )
                .margin(0)
                .padding(.leading,20)
        }
    }
    
}
