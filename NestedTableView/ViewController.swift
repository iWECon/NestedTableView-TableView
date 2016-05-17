//
//  ViewController.swift
//  NestedTableView
//
//  Created by iWe on 16/5/9.
//  Copyright © 2016年 iWe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HandlePreviousCellHeightDelegate {

    @IBOutlet weak var iWTableView: UITableView!
    
    lazy var iwDatas: NSArray = [["1","2","3"], ["一"], ["i", "w", "e"], ["r", "t", "y"], ["a", "s", "d", "b"]]
    
    var cellHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册一个cell
        iWTableView.registerClass(IWTableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func setCellHeight(height: CGFloat, indexPath: NSIndexPath?) {
        cellHeight = height
        tableView(self.iWTableView, heightForRowAtIndexPath: indexPath ?? NSIndexPath(forRow: 0, inSection: 0))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // 如果cellHeight值为空 则取132 否则取cellHeight
        return cellHeight ?? 100;
    }
    
}

extension ViewController: UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // 这里返回节!!!!!!
        return iwDatas.count;
    }
    
    // 父TableView中的每节只需要一个Cell ！ 子TableView会嵌套在此Cell中
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // WARN: 此处只需要返回一个Cell即可
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! IWTableViewCell
        
        if cell.setHeightDelegate == nil {
            cell.setHeightDelegate = self
        }
        if cell.previousTableView == nil {
            cell.previousTableView = self.iWTableView
        }
        
        cell.previousData = (iwDatas[indexPath.section] as! NSArray)
        
        return cell
    }
}
