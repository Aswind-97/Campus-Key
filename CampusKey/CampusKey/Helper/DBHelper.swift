//
//  DBHelper.swift
//  CampusKey
//
//  Created by Nick Martinez on 11/23/20.
//

import Foundation
import SQLite3

class DBHelper {
    var db : OpaquePointer?
    var path : String = "locations.sqlite"
    
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There's an error in creating the database")
            return nil
        } else {
            print("Database has been created with path \(path)")
            return db
        }
    }
    
    func createTable() {
        let query = "CREATE TABLE IF NOT EXISTS foodDB(restaurantID INTEGER PRIMARY KEY AUTOINCREMENT, restaurant TEXT, category TEXT, rating INTEGER, review STRING, picture BLOB);"
        
        var createTable : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("Table creation successful")
            } else {
                print("Table creation failed")
            }
        } else {
            print("Table preparation failed")
        }
    }
    
    
    func insert(restaurant : String, category : String, rating : Int, review : String, picture : Data?) {
        let query = "INSERT INTO foodDB(restaurantID, restaurant, category, rating, review, picture) VALUES (?, ?, ?, ?, ?, ?)"

        var statement : OpaquePointer? = nil

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table creation successful")
            } else {
                print("")
            }
        } else {
            print("Query not as per requirement")
        }
    }
    
}
