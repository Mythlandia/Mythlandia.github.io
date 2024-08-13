//
//  Config.swift
//  VillageLife
//
//  Created by Phil Wigglesworth on 7/27/24.
//

import Foundation
import Ignite

enum Column: Int {
    case uuic,mc_id, street, location, village, district, county
}

func col(_ column: Column) -> Int {
    column.rawValue
}

var config = Config()

var streets: [Street] = []
struct Street {
    var id: UUID
    var mc_id: String
    var street: String
    var location: String
    var village: String
    var district: String
    var county: String
}

class Config {
    var header: [String]
    var colors: [Color] = [.gray,.red, .green, .blue, .purple, .lightGreen, .yellow]
    var table: [[String]]
    var villages: [String]
    var locations: [String]
    var districts: [String]
    
    init() {
        
        guard let csvString = try? String(contentsOfFile: "/Users/philwigglesworth/Projects/mythlandia.github.io/TheVillages/Resources/Streets.csv", encoding: .utf8) else {
            print("CSV file not found")
            fatalError("CSV file not found")
        }
        
        // convert the CSV into a table
        var table = csvStringToArray( csvString: csvString )
        header = table[0]
        table.removeFirst()
        
        self.table = table
        
        for row in table {
            streets.append(
                Street(
                    id: UUID(uuidString: row[0]) ?? UUID(),
                    mc_id: row[1],
                    street: row[2],
                    location: row[3],
                    village: row[4],
                    district: row[5],
                    county: row[6]
                )
            )
        }
        
        let uniqueVillages = Set(table.map { $0[col(.village)] })
        villages = uniqueVillages.sorted()
        
        let uniqueLocations = Set<String>( table.map { Config.locationPrefix( $0[3] ) } )
        locations = Array(uniqueLocations).sorted()
        
        let uniqueDistricts = Set<String>( table.map { $0[5] } )
        districts = Array(
            uniqueDistricts).sorted {
                if let n0 = Int($0) {
                    if let n1 = Int($1) {
                        return n0 < n1
                    } else {
                        return true
                    }
                } else{
                    return $0 < $1
                }
            }
    }
    
    static func locationPrefix(_ location: String) -> String {
        if let prefixIndex = location.firstIndex(of: "-") {
            let locationPrefix = location.prefix(upTo: prefixIndex).trimmingCharacters(in: .whitespacesAndNewlines)
            return String(locationPrefix)
        } else {
            return location
        }
    }
    
    static func locationSuffix(_ location: String) -> String {
        if let prefixIndex = location.firstIndex(of: "-") {
            let locationSuffix = location.suffix(from: prefixIndex).trimmingPrefix("-").trimmingCharacters(in: .whitespacesAndNewlines)
            return String(locationSuffix)
        } else {
            return location
        }
    }
    
    func location(_ locationSuffix: String ) -> String {
        table
            .map{ $0[3] }
            .first(where: {
                //                print("Looking for '\(locationSuffix)' Checking: '\($0)'")
                return String($0).hasSuffix(locationSuffix)
            } ) ?? locationSuffix + " not found"
    }
    
    func sortTable( by column: Int ) {
        table.sort {
            if $0[column].isEmpty { return false }
            else if $1[column].isEmpty { return true }
            else { return $0[column] < $1[column] }
        }
    }
    
}

func csvStringToArray(csvString: String) -> [[String]] {
    
    // create an empty 2-D array to hold the CSV data.
    var dataArray: [[String]] = []
    
    // parse the CSV into rows.
    let csvRows: [String] = csvString.components(separatedBy: "\r\n")
    
    // append each row (1-D array) to dataArray (filling the 2-D array).
    for i in csvRows {
        var columns = i.components(separatedBy: ",")
        if columns.count > 1 {
            columns.insert(UUID().uuidString, at: 0 )
            dataArray.append(columns)
        }
    }
    return dataArray
    
}
