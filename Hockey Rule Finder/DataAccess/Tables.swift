//
//  Tables.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/11/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//
//  Boilerplate code that defines the various columns in the Rules database.
//  Kept here to prevent this from being forced into every data access file in the project.

import Foundation
import SQLite

class LeagueTbl {
    static let league_id = Expression<Int>("league_id");
    static let name = Expression<String>("name");
    static let acronym = Expression<String>("acronym");
}

class SectionTbl {
    static let section_id = Expression<Int>("section_id");
    static let league_id = Expression<Int>("league_id");
    static let section_num = Expression<String>("section_num");
    static let section_name = Expression<String>("section_name");
    static let section_order = Expression<Int>("section_order");
}

class RuleTbl {
    static let rule_id = Expression<Int>("rule_id");
    static let league_id = Expression<Int>("league_id");
    static let section_id = Expression<Int>("section_id");
    static let parent_rule_id = Expression<Int?>("parent_rule_id");
    static let rule_num = Expression<String>("rule_num");
    static let rule_name = Expression<String>("rule_name");
    static let text = Expression<String>("text");
    static let rule_order = Expression<Int>("rule_order");
}