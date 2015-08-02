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
            results.append(getResult(parent, searchText: text));
        }
        
        //Lastly, sort ze list.
        results.sort({ $0.countFound < $1.countFound }); //Possible that the operator needs to be flipped here, just copied from Java version.

        return results;
    }
    
    static func getHighlightedText(var input: String, highlightText: String) -> String {
        if highlightText.isEmpty {
            return input;
        }
        
        var error: NSError?;
        var matcher = NSRegularExpression(pattern: highlightText, options: .CaseInsensitive, error: &error);
        var replaceFormat = "<b><font color=\"Red\">$0</font></b>";
        var inputMutable = NSMutableString(string: input);
        if let response = matcher?.replaceMatchesInString(inputMutable, options: NSMatchingOptions.allZeros, range: NSRange(location:0, length:count(input)), withTemplate: replaceFormat) {
            return inputMutable as String;
        }
        else {
            //Something failed here, log with Crashlytics. TODO CRASHLYTICS.
            return input; //Failed, just return the normal text to prevent the app from crashing.
        }
    }
    
    static func getCondensedVersion(input: String, highlightText: String) -> String {
        //Future TODO: Really should do this via regular expressions, fighting that mess just proves to be a downer.
        var response = "";
        var lines = split(input) { $0 == "\n" }
        
        for line in lines {
            if line.rangeOfString(highlightText) != nil {
                response += line + "\n"
            }
        }
        
        Exceptions.JustMakeItWork(); //Continue rewrite, need to shorten the lines that were found (e.g. "... blah blah text found...")        
        
        return response;
    }
    
    private func getResult (var r: Rule, var searchText: String) -> SearchResult {
        var allContents = "";
        for rule in r.subRules {
            allContents += rule.searchContents + "\n";
        }
        
        //Remove all excess text. 
        var shortVersion = RuleSearcher.getCondensedVersion(allContents, highlightText: searchText);
        var highlightText = "";
        
        if shortVersion.isEmpty {
            highlightText = "No contents";
        }
        else {
            highlightText = RuleSearcher.getHighlightedText(shortVersion, highlightText: searchText);
            highlightText = highlightText.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet());
            highlightText = highlightText.stringByReplacingOccurrencesOfString("\n", withString: "<br /><br />", options: NSStringCompareOptions.allZeros, range: nil);
        }
        
        //TODO (both iOS and Android): GET REAL COUNT BELOW.
        return SearchResult(rMatch:r, sMatch:sections[r.sectionId]!, count:0, highlight:highlightText);
    }
}