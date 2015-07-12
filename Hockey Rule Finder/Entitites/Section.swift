//
//  Section.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/11/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation

class Section {
    var SectionId: Int;
    var LeagueId: Int;
    var Num: String;
    var Name: String;
    var Order: Int;
    
    init(sectionid: Int, leagueid:Int, num: String, name: String, order: Int) {
        SectionId = sectionid;
        LeagueId = leagueid;
        Num = num;
        Name = name;
        Order = order;
    }
}