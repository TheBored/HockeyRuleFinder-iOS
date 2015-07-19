//
//  BaseDataServices.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/19/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation
import SQLite

class BaseDataServices {
    static let DB_PATH = NSBundle.mainBundle().pathForResource("rules", ofType: "sqlite")!;
    
    static func GetTable(table_name: String) -> Query {
        let db = Database(DB_PATH, readonly: true);
        return db[table_name];
    }
}