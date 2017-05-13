//
//  ViewController.swift
//  Final_Project
//
//  Created by CampusUser on 4/28/17.
//  Copyright © 2017 JorgeSalinas. All rights reserved.
//
//code and idea used from https://www.weheartswift.com/
//how-to-make-a-simple-table-view-with-ios-8-and-swift/
//to help on the proccess of tableview

import UIKit

class ViewController: UIViewController, UITableViewDelegate,
            UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var items:[String] = picker1Options
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //currently only a testing number
        return self.items.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text = items[ (indexPath.row)]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //<#code#>
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

