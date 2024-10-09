//
//  LocalDBService.swift
//  AraBook
//
//  Created by 고아라 on 10/9/24.
//

import Foundation

import SQLite3

struct RecentSearchInfo : Codable, Hashable {
    
    var id = UUID()
    let word: String
}

class LocalDBService {
    
    static let shared = LocalDBService()
    
    var db : OpaquePointer?
    var path = "mySqlite.sqlite"
    let TABLE_NAME : String = "myDB"
    
    init(){
        self.db = createDB()
        createTable()
    }
    
    deinit {
        sqlite3_close(db)
    }
    
    func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        do {
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
            
            if !FileManager.default.fileExists(atPath: filePath.path) {
                if sqlite3_open(filePath.path, &db) == SQLITE_OK {
                    print("Successfully created Database at path: \(filePath.path)")
                    return db
                }
            } else {
                if sqlite3_open(filePath.path, &db) == SQLITE_OK {
                    print("Successfully opened existing Database at path: \(filePath.path)")
                    return db
                }
            }
        } catch {
            print("ERROR in createDB - \(error.localizedDescription)")
        }
        
        print("ERROR in createDB - sqlite3_open ")
        return nil
    }
    
    func createTable(){
        let query = "create table if not exists myDB(id INTEGER primary key autoincrement, word TEXT not null);"
        
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Create Table SuccessFully \(String(describing: db))")
            }
            else{
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n Create Table step fail :  \(errorMessage)")
            }
        }
        else{
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\n create Table sqlite3_prepare Fail ! :\(errorMessage)")
            
        }
        
        sqlite3_finalize(statement)
    }
    
    func insertData(word: String){
        let query = "insert into myDB (id, word) values (?,?);"
        var statement : OpaquePointer? = nil
        do {
            let data = try JSONEncoder().encode(word)
            let dataToString = String(data: data, encoding: .utf8)
            if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 2, NSString(string: word).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Insert data SuccessFully : \(String(describing: db))")
                }
                else {
                    let errorMessage = String(cString: sqlite3_errmsg(db))
                    print("\n insert Data sqlite3 step fail! : \(errorMessage)")
                }
            }
            else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\n insert Data prepare fail! : \(errorMessage)")
            }
            sqlite3_finalize(statement)
        }
        catch {
            print("JSONEncoder Error : \(error.localizedDescription)")
        }
    }
    
    func getData() -> [RecentSearchInfo] {
        let query = "SELECT word FROM myDB ORDER BY id DESC;"
        
        var statement: OpaquePointer? = nil
        var recentSearchList = [RecentSearchInfo]()
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            
            while sqlite3_step(statement) == SQLITE_ROW {
                if let queryResultCol1 = sqlite3_column_text(statement, 0) {
                    let recentWord = String(cString: queryResultCol1)
                    let recentSearchInfo = RecentSearchInfo(word: recentWord)
                    recentSearchList.append(recentSearchInfo)
                }
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Fetch prepare fail! : \(errorMessage)")
        }
        
        sqlite3_finalize(statement)
        return recentSearchList
    }
    
    func deleteRecentSearch(id: UUID) {
        let query = "DELETE FROM myDB WHERE word = ?;"
        
        var statement: OpaquePointer? = nil
        
        do {
            let recentSearchInfo = RecentSearchInfo(id: id, word: "")
            let data = try JSONEncoder().encode(recentSearchInfo)
            let dataToString = String(data: data, encoding: .utf8)
            
            if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
                sqlite3_bind_text(statement, 1, NSString(string: dataToString!).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Delete search successfully by id: \(id)")
                } else {
                    let errorMessage = String(cString: sqlite3_errmsg(db))
                    print("Delete search step fail: \(errorMessage)")
                }
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("Delete search prepare fail: \(errorMessage)")
            }
            
            sqlite3_finalize(statement)
            
        } catch {
            print("JSONEncoder Error: \(error.localizedDescription)")
        }
    }
    
    func deleteDatabase() {
        do {
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
            try FileManager.default.removeItem(at: filePath)
            print("Database file deleted successfully.")
        } catch {
            print("Could not delete database file: \(error.localizedDescription)")
        }
    }
}
