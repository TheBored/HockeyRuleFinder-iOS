//
//  RuleSearcherTests.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 8/2/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import XCTest	

class RuleSearcherTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testGetCondensedVersion() {
        var input = "Line 1\nLine 2\nLine 3 Target\nLine 4\nLine 5 Target\nLine 6\n";
        var highlight = "Target";
        
        var result = RuleSearcher.getCondensedVersion(input, highlightText: highlight);
        
        var expectedResult = "Line 3 Target\nLine 5 Target\n";
        XCTAssertEqual(result, expectedResult, "Did not receive expected result from RuleSearcher.getCondensedVersion");
    }
    
    func testGetHighlightedText() {
        var input = "This is the target text.";
        var highlight = "target";
        var result = RuleSearcher.getHighlightedText(input, highlightText: highlight);
        var expectedResult = "This is the <b><font color=\"Red\">target</font></b> text.";
        XCTAssertEqual(result, expectedResult, "Did not receive expected result from RuleSearcher.getHighlightedText");
    }
}
