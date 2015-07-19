//
//  RuleDataServices.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/11/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation
import SQLite

class RuleDataServices: BaseDataServices {
    
    static func GetAllSections(leagueId: Int) -> [Section] {
        var response = [Section]();
        var sectionTable = GetTable("section");
        for s in sectionTable.filter(SectionTbl.league_id == leagueId) {
            let newSec = Section(dbRow: s);
            response.append(newSec);
        }
        return response;
    }
    
    static func GetRulesForSection(sectionId: Int) -> [Rule] {
        var response = [Rule]();
        var ruleTable = GetTable("rule");
        for r in ruleTable.filter(RuleTbl.section_id == sectionId) {
            let newRule = Rule(dbRow: r);
            response.append(newRule);
        }
        return MakeTree(response);
    }
    
    //Input: flat list of rules. Output: heirarchy of rules, where parentless rules are the first level of the list.
    private static func MakeTree(inputList: [Rule]) -> [Rule] {
        var flatList = inputList;
        var response = [Rule]();
        for index in stride(from: flatList.count - 1, through: 0, by: -1) { //Iterate over the flat list, in reverse.
            var last = flatList.removeLast();
            if let parentRuleId = last.parentRuleId { //We have a parent
                if let found = find(flatList.map({ $0.ruleId }), parentRuleId) { //Find them in our other results.
                    flatList[found].subRules.insert(last, atIndex: 0); //Set this as a child.
                } else {
                    //Not found for some reason, throw an exception to cause a big stink. 
                    var e = NSException(name:"RuleNotFoundException", reason:"Rule Not Found", userInfo:["ruleId":last.ruleId])
                    e.raise()
                }
            } else { //No parent. Insert to the main list, to be returned.
                response.insert(last, atIndex: 0);
            }
        }
        return response;
    }
}