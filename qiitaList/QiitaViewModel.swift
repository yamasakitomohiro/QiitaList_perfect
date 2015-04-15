//
//  QiitaViewModel.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit
let NoticeUpdated = "NoticeUpdated"
let CellId = "CellId"

class QiitaViewModel: NSObject,UITableViewDelegate, UITableViewDataSource  {
    var mQiitList: [AnyObject] = []
    var mRequestTask: NSURLSessionDataTask?
    override init() {
        super.init()
    }
    
    func tableUpdate(sender: AnyObject) {
        // create the url-request
        var request = NSMutableURLRequest(URL: NSURL(string: "https://qiita.com/api/v2/items")!)
        
        // set the method(HTTP-GET)
        request.HTTPMethod = "GET"
        
        
        mRequestTask?.cancel();
        // use NSURLSession
        mRequestTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
            if (error == nil) {
                var result = NSString(data: data, encoding: NSUTF8StringEncoding)!
                self.mQiitList = result.componentsSeparatedByString("。")
                
//                if (NSJSONSerialization.isValidJSONObject(result)){
//                    var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
//
//                }
                NSNotificationCenter.defaultCenter().postNotificationName(NoticeUpdated, object: nil)

            } else {
                println(error)
            }
        })
        mRequestTask!.resume()
    }
    
    // MARK: - DataSourceメソッド
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellId);
        cell.textLabel?.text = mQiitList[indexPath.row] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mQiitList.count ?? 0;
    }
}
