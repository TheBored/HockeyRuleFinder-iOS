//
//  OfficialListViewController.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 7/19/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

import Foundation

class OfficialListViewController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var tableData = [Official]();
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
        tableData = OfficialDataServices.GetAllOfficials(1);
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
        var o: Official = tableData[indexPath.row];
        cell.textLabel!.text = String(o.number) + o.name;
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndex = indexPath.row;
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("main", forIndexPath:indexPath) as! UITableViewCell;
        self.performSegueWithIdentifier("to_official_detail", sender: cell);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "to_rule_list") {
            if let viewController: RuleListController = segue.destinationViewController as? RuleListController {
                let cell:UITableViewCell = sender as! UITableViewCell;
                var o: Official = tableData[selectedIndex];
                //viewController.sectionId = io.sectionId;
            }
        }
    }
    
}