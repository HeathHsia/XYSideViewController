//
//  SecondViewController.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by kaopuniao on 2017/8/17.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    static let TABLEVIEWCELLIDENTIFIER = "TABLEVIEWCELLIDENTIFIER"
    let imageArray = ["01", "06", "10", "11", "13"]
    let titleArray = ["地图", "森林", "赛场", "游水", "山间"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地球"
        view.backgroundColor = .white
        setUpCustomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    lazy var rootTableView : UITableView = { [unowned self] in
       
        var tableView : UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: TABLEVIEWCELLIDENTIFIER)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func setUpCustomView() {
        view.addSubview(rootTableView)
    }
}


extension SecondViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SecondViewController.TABLEVIEWCELLIDENTIFIER, for: indexPath)
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.imageView?.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let otherVC = OtherViewController()
        otherVC.title = titleArray[indexPath.row]
        navigationController?.pushViewController(otherVC, animated: true)
    }
    
}

