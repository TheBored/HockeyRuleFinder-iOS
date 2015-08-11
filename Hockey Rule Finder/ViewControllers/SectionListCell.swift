//
//  SectionListCell.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 8/10/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation

class SectionListCell : UITableViewCell {
    @IBOutlet weak var sectionName: UILabel!
    @IBOutlet weak var sectionDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}