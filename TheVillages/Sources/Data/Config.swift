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

var config: Config!

class Config {
    var header: [String]
    var table: [[String]]
    var colors: [Color] = [.gray,.red, .green, .blue, .purple, .lightGreen, .yellow]
    var villages: [String]
    
    init(context: PublishingContext) {
        let url = context.url(forResource: "Streets.csv")
        

        
        guard let csvString = try? String(contentsOfFile: "/Users/philwigglesworth/Projects/Ignite/TheVillages/Assets/The Villages Street Names.csv", encoding: .utf8) else {
            print("CSV file not found")
            fatalError("CSV file not found")
        }
        
        // convert the CSV into a table
        var table = csvStringToArray( csvString: csvString )
        header = table[0]
        table.removeFirst()
        self.table = table

        let uniqueVillages = Set(table.map { $0[col(.village)] })
        villages = uniqueVillages.sorted()
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

