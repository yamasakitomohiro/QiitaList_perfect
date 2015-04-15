//
//  QiitaListView.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit

class QiitaListView: UIView {
    var mModel :QiitaViewModel
    var mTable :UITableView
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame: CGRect,model: QiitaViewModel) {
        mModel = model
        mTable = UITableView(frame: CGRectMake(0, 0, frame.width, frame.size.height - 50), style: UITableViewStyle.Plain);
        mTable.registerClass(UITableViewCell.self, forCellReuseIdentifier:CellId);
        
        super.init(frame: frame);
        self.addSubview(mTable);
        mTable.dataSource = mModel;
        mTable.delegate   = mModel;
        
        let reloadBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
        reloadBtn.addTarget(mModel, action: "tableUpdate:", forControlEvents: .TouchUpInside);
        reloadBtn.setTitle("更新", forState: UIControlState.Normal);
        reloadBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal);
        reloadBtn.sizeToFit();
        reloadBtn.center = CGPointMake(self.frame.width / 2,self.frame.height - 20);
        self.addSubview(reloadBtn);
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update:", name: NoticeUpdated, object: nil)
        
    }
    
    func update(notification: NSNotification?) {
        dispatch_async(dispatch_get_main_queue(), {
            self.mTable.reloadData();
        })
    }

}
