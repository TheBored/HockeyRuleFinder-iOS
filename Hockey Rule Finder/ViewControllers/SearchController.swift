//
//  SearchController.swift
//  Hockey Rule Finder
//
//  Created by Brian Maxwell on 6/14/15.
//  Copyright (c) 2015 Brian Maxwell. All rights reserved.
//

class SearchController: UIViewController {
    
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var searchActive = false;
    var searchText = "";
    var tableData = [SearchResult]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        var searcher = RuleSearcher(leagueId: 1);
        tableData = searcher.searchRules("boarding", leagueId: 1);
    }
    
    func search() {
        return;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText;
        return;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.tableData.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath:indexPath) as! UITableViewCell;
        cell.textLabel!.text = tableData[indexPath.row].highlightText;
        return cell;
    }
}

