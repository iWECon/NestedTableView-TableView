//
//  IWTableViewCell.swift
//  NestedTableView
//
//  Created by iWe on 16/5/9.
//  Copyright © 2016 iWe. All rights reserved.
//

import UIKit

/**
 *  处理父cell的height
 */
protocol HandlePreviousCellHeightDelegate {
    func setCellHeight(height: CGFloat, indexPath: NSIndexPath?)
}

class IWTableViewCell: UITableViewCell {
    // 代理
    var setHeightDelegate: HandlePreviousCellHeightDelegate!
    var previousTableView: UITableView!
    
    var previousData: NSArray? {
        // set后刷新列表并计算父Cell高度
        didSet {
            self.iwTableView.reloadData()
            self.resetCellSize()
        }
    }

    lazy var iwTableView: UITableView = {
        let tb = UITableView(frame: CGRectMake(0, 0, 320, 0))
        tb.registerClass(IWETableViewCell.self, forCellReuseIdentifier: "cell")
        tb.dataSource = self
        tb.tableFooterView = UIView()
        tb.scrollEnabled = false
        return tb
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 自动处理子视图大小 关闭
        self.autoresizesSubviews = false
        
        self.addSubview(iwTableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
    重新计算整个视图大小, 计算父TableViewCell的大小
    */
    func resetCellSize() {
        // 默认每个cell的高度为44
        let cellHeight = 44
        
        let sections = self.iwTableView.numberOfSections
        
        var newCellHeight: CGFloat
        for var i = 0; i < sections; i++ {
            let rows = self.iwTableView.numberOfRowsInSection(i)
            
            newCellHeight = CGFloat(rows * cellHeight)
            self.frame.size.height = newCellHeight
            self.iwTableView.frame.size.height = newCellHeight
            
            let index = previousTableView.indexPathForCell(self)
            setHeightDelegate.setCellHeight(newCellHeight, indexPath: index)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension IWTableViewCell: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
         这个地方没有OC好玩, OC识别为nib时不会崩溃,直接返回0。 
         Swift直接崩溃, 所以做个判断
        
         此处将previousData改成了Option数据, 第一次加载列表的时候, previousData还未有数据, 所以返回0行, previousData写入数据后会自动刷新列表, 再返回count
        */
        if previousData == nil {
            return 0
        }
        return previousData!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! IWETableViewCell
        
        // 防止previousData数据为空崩溃
        if previousData != nil {
            cell.textLabel?.text = previousData![indexPath.row] as? String
        }
        
        return cell;
    }
}
