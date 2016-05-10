# NestedTableView-TableView
Cell中加入TableView 多重TableView


/**
    重新计算整个视图大小
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
