//
//  ViewController.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by kaopuniao on 2017/8/11.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let ROOTTABLEVIEWCELLIDENTIFIER = "ROOTTABLEVIEWCELLIDENTIFIER"
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "风景"
        view.backgroundColor = .white
        view.addSubview(rootTableView)
    }
    
    lazy var rootTableView : UITableView = { [unowned self] in
        var tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: ROOTTABLEVIEWCELLIDENTIFIER)
        return tableView
    }()
    
    lazy var titleArray : [String] = { [unowned self] in
        var array = ["夜晚", "山脉", "龙卷风", "农场", "富士山", "海底"]
        return array
    }()

    let imageArray : [String] = {
        let array = ["yewan", "shan", "feng", "chang", "fushi", "haidi"]
        return array
    }()
}

// MARK -- TableView Delegate
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.ROOTTABLEVIEWCELLIDENTIFIER, for: indexPath)
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.imageView?.image = UIImage(named: self.imageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}



