//
//  OfficialDataServices.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/19/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation
import SQLite

class OfficialDataServices: BaseDataServices {
    
    static func GetAllOfficials(leagueId: Int) -> [Official] {
        var response = [Official]();
        var officialTable = GetTable("official");
        for o in officialTable.filter(SectionTbl.league_id == leagueId) {
            let newOfficial = Official(dbRow: o);
            response.append(newOfficial);
        }
        return response;
    }
}