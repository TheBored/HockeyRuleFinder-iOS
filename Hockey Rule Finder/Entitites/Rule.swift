//
//  Rule.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/14/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation
import SQLite

class Rule {
    var ruleId: Int;
    var leagueId: Int;
    var sectionId: Int;
    var parentRuleId: Int?;
    var ruleNum: String;
    var ruleName: String;
    var text: String;
    var ruleOrder: Int;
    var subRules: [Rule];
    
    init(dbRow: Row) {
        ruleId = dbRow[RuleTbl.rule_id];
        leagueId = dbRow[RuleTbl.league_id];
        sectionId = dbRow[RuleTbl.section_id];
        parentRuleId = dbRow[RuleTbl.parent_rule_id];
        ruleNum = dbRow[RuleTbl.rule_num];
        ruleName = dbRow[RuleTbl.rule_name];
        text = dbRow[RuleTbl.text];
        ruleOrder = dbRow[RuleTbl.rule_order];
        subRules = [Rule]();
    }
}