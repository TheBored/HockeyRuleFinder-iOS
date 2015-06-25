//
//  MenuController.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 6/11/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation

class MenuController: UIViewController {
    
    let tableData = ["quick_reference", "browse", "search", "officials_list"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tableData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier:String = tableData[indexPath.row];
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath:indexPath) as! UITableViewCell;
        return cell;
    }
}

