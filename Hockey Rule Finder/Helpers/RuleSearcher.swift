//
//  RuleSearcher.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/20/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation

class RuleSearcher {
    private static let SEARCH_BUFFER_SPACE = 45;
    
    private var leagueId: Int;
    private var sections: [Int: Section];
    
    // Begin at start of line. Find the first occurence of the search term.
    // Attempt to match %d characters before the search term. Any additional
    // characters past 45 will be replaced with "...".
    private static let REGEX_FIRST_TERM = "^(.*?)(.{0,%d})(%s)(.*)$";
    
    //Match any lines that don't contain the term at all.
    private static let REGEX_HAS_TERM = "^.*(%s).*$";
    
    //Match any gaps between terms with a length greater than defined limit.
    private static let REGEX_AFTER_TERM = "(%s)((?!%s).{%d,}?)(%s|$)";
    
    init(leagueId: Int) {
        sections = [Int: Section]();
        self.leagueId = leagueId;
        setSectionCache();
    }
    
    //Section data is used with every search result. Cache it here for later use.
    //This will be invalidated should the leagueId change.
    private func setSectionCache() {
        var sLst = RuleDataServices.GetSectionsForLeague(leagueId);
        for s in sLst {
            sections[s.sectionId] = s;
        }
    }
    
    func searchRules(var text: String, leagueId:Int) -> [SearchResult] {
        //If the league ID has changed, reset the section cache.
        if (leagueId != leagueId) {
            self.leagueId = leagueId;
            setSectionCache();
        }
        
        var results = [SearchResult]();
        
        //Before anything starts, trim just in case.
        text = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
        
        //No search text = no results.
        if (text.isEmpty) {
            return results;
        }
        
        //First up, find any rules that might have the text we are interested in.
        var directReferences = RuleDataServices.FindRulesWithText(leagueId, text: text);
        
        //Their search returns no direct references -- nothing to see here.
        if (directReferences.count == 0) {
            return results;
        }
        
        //With these Ids, go back to the database and get all of those rules again with any parents
        //that aren't already in the list. Also puts them into a tree.
        var possibleReferences = RuleDataServices.GetRules(leagueId, sectionId: nil, ruleIds: directReferences, returnFlat: false);
        
        for parent in possibleReferences {
            results.append(getResult(parent, searchText: text)!);
        }
        
        //Lastly, sort ze list.
        results.sort({ $0.countFound < $1.countFound }); //Possible that the operator needs to be flipped here, just copied from Java version.

        return results;
    }
    
    private func getResult (var r: Rule, var searchText: String) -> SearchResult? { //NOTE: WHen this is implemented, be sure to remove the nullable return value. Should be mandatory.
        Exceptions.ThrowNotImplemented();
        return nil;
    }
}