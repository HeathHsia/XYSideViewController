//
//  SideViewController.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by kaopuniao on 2017/8/17.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

import UIKit

class SideViewController: UIViewController {

    static let TABLEVIEWCELLIDENTIFIER = "TABLEVIEWCELLIDENTIFIER"
    let titleArray = ["骑行", "旅游", "摄影", "Steam"]
    let imageArray = ["02", "04", "07", "05"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backImage)
        view.addSubview(rootTableView)
    }

    lazy var backImage : UIImageView = { [unowned self] in
        var image = UIImageView(image: UIImage(named: "image.jpeg"))
        image.frame = self.view.bounds
        image.alpha = 0.85
        return image
    }()
    
    lazy var rootTableView : UITableView = { [unowned self] in
        var tableView : UITableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: TABLEVIEWCELLIDENTIFIER)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
}

extension SideViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideViewController.TABLEVIEWCELLIDENTIFIER, for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.imageView?.image =    UIImage(named: imageArray[indexPath.row])
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.backgroundColor = .clear
        headView.alpha = 1
        
        let author = UILabel()
        author.frame = CGRect(x: 10, y: 30, width: 300, height: 100)
        author.textAlignment = NSTextAlignment.left
        author.font = UIFont.systemFont(ofSize: 20)
        author.text = "Author: FireHsia\nE-mail: firehsia1204@gmail.com\n欢迎邮件  欢迎Star"
        author.numberOfLines = 0
        author.textColor = .white
        author.backgroundColor = .clear
        headView.addSubview(author)
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let delegate  = UIApplication.shared.delegate! as! AppDelegate
        let rootVC = delegate.window?.rootViewController as! XYSideViewControllerSwift
        rootVC.closeSideVC()
        let otherVC = OtherViewController()
        otherVC.title = titleArray[indexPath.row]
        rootVC.currentNavController?.pushViewController(otherVC, animated: true)
        
    }
}
