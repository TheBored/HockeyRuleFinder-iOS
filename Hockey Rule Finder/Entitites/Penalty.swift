//
//  Penalty.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/19/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//
//  Note: Items in this class are also referred to as "Call" in the database. 
//        A class named "Call" seemed to be less than desireable, so Penalty.

import Foundation
import SQLite

class Penalty {
    var callId: Int;
    var leagueId: Int;
    var ruleId: Int?;
    var name: String;
    var desc: String;
    var img: String;
    
    init(dbRow: Row) {
        callId = dbRow[CallTbl.call_id];
        leagueId = dbRow[CallTbl.league_id];
        ruleId = dbRow[CallTbl.rule_id];
        name = dbRow[CallTbl.name];
        desc = dbRow[CallTbl.desc];
        img = dbRow[CallTbl.img];
    }
}