//
//  ContentViewController.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 6/6/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import UIKit
import SQLite

class SectionListController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var tableData = [Section]();
    var selectedIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
  
        //Quick hack for testing SQLite
        tableData = RuleDataServices.GetSectionsForLeague(1);
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
        let cell:SectionListCell = tableView.dequeueReusableCellWithIdentifier("sectionListCell", forIndexPath:indexPath) as! SectionListCell;
        var s: Section = tableData[indexPath.row];
        cell.sectionName!.text = s.name;
        cell.sectionDetails!.text = "Words";
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndex = indexPath.row;
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("sectionListCell", forIndexPath:indexPath) as! SectionListCell;
        self.performSegueWithIdentifier("to_rule_list", sender: cell);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "to_rule_list") {
            if let viewController: RuleListController = segue.destinationViewController as? RuleListController {
                var s: Section = tableData[selectedIndex];
                viewController.sectionId = s.sectionId;
            }
        }
    }
}

