//
//  QiitaViewModel.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit
let CellId = "CellId"

class QiitaViewModel: NSObject,UITableViewDelegate, UITableViewDataSource  {
    var qiitList: [AnyObject] = []
    private var mRequestTask: NSURLSessionDataTask?
    override init() {
        super.init()
    }
    
    func updateQiitaList(complated:() -> Void) {
        qiitList = []
        
        WebApi.jsonObject("https://qiita.com/api/v2/items", complated: { (jsonObject:AnyObject?) -> Void in
            if let qiitaJsonObject: AnyObject = jsonObject{
                for origin in qiitaJsonObject as! [[String:AnyObject]]{
                    self.qiitList.append(origin["title"] as! String)
                }
                complated()
            }else{
                complated()
            }
        })
    }
    
    
    // MARK: - DataSourceメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellId);
        cell.textLabel?.text = qiitList[indexPath.row] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qiitList.count ?? 0;
    }
}
