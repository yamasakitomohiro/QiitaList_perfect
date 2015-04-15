//
//  QitaListViewController.swift
//  qiitaList
//
//  Created by 山崎友弘 on 2015/04/11.
//  Copyright (c) 2015年 basic. All rights reserved.
//

import UIKit

class QitaListViewController: UIViewController {
    // MARK: - ライフサイクル系
    let mModel = QiitaViewModel();
    override func loadView() {
        super.loadView()
        self.view = QiitaListView(frame: self.view.bounds,model:mModel);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
