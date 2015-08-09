//
//  QuickReferenceController.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 6/11/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

class QuickReferenceController: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var tableData = [Penalty]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        tableData = RuleDataServices.GetPenaltiesForLeague(1);
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
        let cell = tableView.dequeueReusableCellWithIdentifier("QuickRefCell", forIndexPath: indexPath) as! QuickRefereceCell
        cell.ruleName.text = tableData[indexPath.row].name;
        cell.ruleDesc.text = tableData[indexPath.row].desc;
        
        //Get the name of the image - but get the thumbnail version.
        let thumbnailName = tableData[indexPath.row].img.stringByReplacingOccurrencesOfString("_", withString:"_sm_");
        cell.ruleImg.image = UIImage(named: thumbnailName);
        
        return cell;
    }
    
}

