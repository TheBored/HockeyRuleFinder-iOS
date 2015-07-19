//
//  Official.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/19/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation
import SQLite

class Official {
    var officialId: Int;
    var leagueId: Int;
    var number: Int;
    var name: String;
    var leagueDesc: String;
    var memberSince: String;
    var countRegSeason: String;
    var countPlayoffs: String;
    var firstRegSeason: String;
    var firstRegGame: String;
    var firstPlayoffSeason: String;
    var firstPlayoffGame: String;
    
    init(dbRow: Row) {
        officialId = dbRow[OfficialTbl.official_id];
        leagueId = dbRow[OfficialTbl.official_id];
        number = dbRow[OfficialTbl.number];
        name = dbRow[OfficialTbl.name];
        leagueDesc = dbRow[OfficialTbl.league_desc];
        memberSince = dbRow[OfficialTbl.member_since];
        countRegSeason = dbRow[OfficialTbl.count_reg_season];
        countPlayoffs = dbRow[OfficialTbl.count_playoffs];
        firstRegSeason = dbRow[OfficialTbl.first_reg_season];
        firstRegGame = dbRow[OfficialTbl.first_reg_game];
        firstPlayoffSeason = dbRow[OfficialTbl.first_playoff_season];
        firstPlayoffGame = dbRow[OfficialTbl.first_playoff_game];
    }
}
