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
    
    static func GetSectionsForLeague(leagueId: Int) -> [Section] {
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
    
    static func GetPenaltiesForLeague(leagueId: Int) -> [Penalty] {
        var response = [Penalty]();
        var penaltyTable = GetTable("call");
        for p in penaltyTable.filter(CallTbl.league_id == leagueId) {
            let newPenalty = Penalty(dbRow: p);
            response.append(newPenalty);
        }
        return response;
    }
    
    static func GetRules(leagueId: Int?, sectionId: Int?, ruleIds: [Int], returnFlat: Bool) -> [Rule] {
        var response = [Rule]();
        var ruleTbl = GetTable("rule");
        
        //Filter on each item, if required.
        if let lid = leagueId {
            ruleTbl = ruleTbl.filter(RuleTbl.league_id == lid);
        }
        if let sid = sectionId {
            ruleTbl = ruleTbl.filter(RuleTbl.section_id == sid);
        }
        
        if (ruleIds.count > 0) {
            //rule_id or parent_rule_id is in the provided IDs.
            ruleTbl = ruleTbl.filter(contains(ruleIds, RuleTbl.rule_id) || contains(ruleIds, RuleTbl.parent_rule_id));
        }
        
        //Convert to an array.
        for ruleRow in ruleTbl {
            var newRule = Rule(dbRow: ruleRow);
            response.append(newRule);
        }
        
        //Convert it to a tree, if desired.
        if (returnFlat) {
            return response;
        }
        else {
            return MakeTree(response);
        }
    }
    
    static func FindRulesWithText(leagueId: Int, text: String) -> [Int] {
        var response = [Int]();
        
        var ruleTbl = GetTable("Rule");
        
        //League Id required.
        ruleTbl = ruleTbl.filter(RuleTbl.league_id == leagueId);
        
        //Search all text fields.
        let pattern = "%" + text + "%";
        ruleTbl = ruleTbl.filter(like(pattern, RuleTbl.text) || like(pattern, RuleTbl.rule_name) || like(pattern, RuleTbl.rule_num));
        
        //Get the appropriate IDs. If we get a child rule, return the parent. Otherwise just return the rule.
        for ruleRow in ruleTbl {
            var newId = ruleRow[RuleTbl.parent_rule_id] != nil ? ruleRow[RuleTbl.parent_rule_id]! : ruleRow[RuleTbl.rule_id];
            response.append(newId);
        }
        
        return response;
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