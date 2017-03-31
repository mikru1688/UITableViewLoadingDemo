//
//  ViewController.swift
//  UITableViewLoadingDemo
//
//  Created by Frank.Chen on 2017/3/31.
//  Copyright © 2017年 Frank.Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var dataListA: [Int] = [0] // 原資料
    var dataListB: [Int] = Array<Int>(1...300) // 要被載入的資料
    var startIndex: Int = 0 // 要被載入的資料的起始索引
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // 生成tableVeiw
        self.tableView = UITableView(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        // 生成refreshControl
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(ViewController.refresh), for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "loading...")
        self.tableView?.addSubview(refreshControl)
    }
    
    // MARK: - DataSource
    // ---------------------------------------------------------------------
    // 設定表格section的列數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataListA.count
    }
    
    // MARK: - Delegate
    // ---------------------------------------------------------------------
    // 表格的儲存格設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        }
        cell!.textLabel?.text = String(dataListA[indexPath.row])
        
        return cell!
    }
    
    /// 載入資料
    func refresh() {
        let endIndex: Int = self.startIndex + 3
        self.dataListA += self.dataListB[self.startIndex..<endIndex]
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
        self.startIndex += 3
    }
}




