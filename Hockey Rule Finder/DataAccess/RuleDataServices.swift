//
//  RuleDataServices.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/11/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation
import SQLite

class RuleDataServices {
    static let DB_PATH = NSBundle.mainBundle().pathForResource("rules", ofType: "sqlite")!;
    
    static func GetTable(table_name: String) -> Query {
        let db = Database(DB_PATH, readonly: true);
        return db[table_name];
    }
    
    static func GetAllSections(leagueid: Int) -> [Section] {
        var response = [Section]();
        var section_table = GetTable("section");
        for s in section_table.filter(SectionTbl.league_id == 1) {
            let newSec = Section(sectionid: s[SectionTbl.section_id],
                leagueid: s[SectionTbl.league_id],
                num: s[SectionTbl.section_num],
                name: s[SectionTbl.section_name],
                order: s[SectionTbl.section_order]);
            response.append(newSec);
        }
        return response;
    }
}