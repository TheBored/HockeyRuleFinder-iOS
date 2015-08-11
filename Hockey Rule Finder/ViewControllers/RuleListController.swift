//
//  RuleListController.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 6/12/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

class RuleListController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var tableData = [Rule]();
    var selectedIndex = 0;
    var sectionId = -1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        tableData = RuleDataServices.GetRulesForSection(sectionId);
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
        let cell:RuleListCell = tableView.dequeueReusableCellWithIdentifier("ruleListCell", forIndexPath:indexPath) as! RuleListCell;

        cell.ruleName!.text = tableData[indexPath.row].ruleName;
        if (tableData[indexPath.row].ruleNum == "PREFIX")
        {
            cell.ruleDetails!.text = tableData[indexPath.row].ruleNum;
        }
        else
        {
            cell.ruleDetails!.text = "Rule " + tableData[indexPath.row].ruleNum;
        }
        return cell;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndex = indexPath.row;
        let cell:RuleListCell = tableView.dequeueReusableCellWithIdentifier("ruleListCell", forIndexPath:indexPath) as! RuleListCell;
        self.performSegueWithIdentifier("to_rule_detail", sender: cell);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "to_rule_detail") {
            if let viewController: RuleDetailController = segue.destinationViewController as? RuleDetailController {
                let cell:UITableViewCell = sender as! UITableViewCell;
                viewController.setData(tableData[selectedIndex].subRules);
            }
        }
    }
}

