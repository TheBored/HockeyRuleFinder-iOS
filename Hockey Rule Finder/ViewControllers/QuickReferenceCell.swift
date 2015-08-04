//
//  QuickReferenceCell.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 8/3/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation

class QuickRefereceCell : UITableViewCell {
    @IBOutlet weak var ruleName: UILabel!
    @IBOutlet weak var ruleDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}