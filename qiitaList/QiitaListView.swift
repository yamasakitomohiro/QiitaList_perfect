//
//  QiitaListView.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit

class QiitaListView: UIView {
    let table :UITableView
    let refreshControl:UIRefreshControl
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame: CGRect,model: QiitaViewModel) {
        table = UITableView(frame: CGRectMake(0, 0, frame.width, frame.size.height), style: UITableViewStyle.Plain);
        refreshControl = UIRefreshControl()
        table.addSubview(refreshControl)
        
        
        super.init(frame: frame);
        
        self.addSubview(table);
    }

}
