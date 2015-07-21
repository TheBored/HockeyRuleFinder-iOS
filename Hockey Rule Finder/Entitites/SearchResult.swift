//
//  SearchResult.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/20/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation

public class SearchResult {
    var highlightText: String;
    var countFound: Int;
    var ruleMatch: Rule;
    var sectionMatch: Section;
    
    init(rMatch: Rule, sMatch: Section, count: Int, highlight: String) {
        highlightText = highlight;
        countFound = count;
        ruleMatch = rMatch;
        sectionMatch = sMatch;
    }
}