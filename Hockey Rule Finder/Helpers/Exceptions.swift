//
//  Exceptions.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/20/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation

//Quick and dirty to avoid rewriting this over and over while I implement new features.
class Exceptions {
    static func ThrowNotImplemented() {
        let exception = NSException(
            name: "Not implemented!",
            reason: "See name",
            userInfo: nil
        )
        exception.raise();
    }
    
    //Don't want the app to crash later, but will use this to find under developed features later.
    static func JustMakeItWork() {
        //Do nothing for now
    }
}