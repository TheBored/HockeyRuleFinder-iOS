//
//  ContentViewController.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 6/6/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import UIKit

class SectionListController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let tableData = ["B1", "B2", "B3"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tableData.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"main");
        cell.textLabel!.text = tableData[indexPath.row];
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("main", forIndexPath:indexPath) as! UITableViewCell;
        self.performSegueWithIdentifier("to_rule_list", sender: cell);
    }
    
}

