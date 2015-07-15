//
//  Section.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/11/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation
import SQLite

class Section {
    var sectionId: Int;
    var leagueId: Int;
    var num: String;
    var name: String;
    var order: Int;
    
    init(dbRow: Row) {
        sectionId = dbRow[SectionTbl.section_id];
        leagueId = dbRow[SectionTbl.league_id];
        num = dbRow[SectionTbl.section_num];
        name = dbRow[SectionTbl.section_name];
        order = dbRow[SectionTbl.section_order];
    }
}