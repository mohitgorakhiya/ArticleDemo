//
//  ViewController.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/2/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constant.MainViewTitle
        
        self.mainTableView.register(UINib.init(nibName: "HeaderTextView", bundle:nil), forHeaderFooterViewReuseIdentifier: "HeaderTextView")
        self.mainTableView.register(UINib.init(nibName: "MainTableViewCell", bundle:nil), forCellReuseIdentifier: "MainTableViewCell")

//        self.mainTableView.estimatedRowHeight = 500.0
//        self.mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.estimatedSectionHeaderHeight = 100.0
        self.mainTableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        self.mainTableView.separatorStyle = .none
        self.mainTableView.tableFooterView = UIView(frame: .zero)
        
        self.viewModel.loadTableData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainTableView.reloadData()
    }

    lazy var viewModel: MainViewModel = {
        return MainViewModel()
    }()
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderTextView") as! HeaderTextView
        
        headerView.titleLabel.text = viewModel.headerTextList[section]
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return viewModel.headerTextList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return viewModel.searchTypeList.count
        }
        else
        {
            return viewModel.popularTypeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let mainCell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        if indexPath.section == 0
        {
            mainCell.configureCell(cellModel: self.viewModel.searchTypeList[indexPath.row])
        }
        else
        {
            mainCell.configureCell(cellModel: self.viewModel.popularTypeList[indexPath.row])
        }
        return mainCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0
        {
            let searchVC = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.SearchViewController.rawValue) as! SearchViewController
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
        else
        {
            let articleListVC = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.ArticlesListViewController.rawValue) as! ArticlesListViewController
            articleListVC.viewModel.articleType = self.viewModel.popularTypeList[indexPath.row].articleType
            self.navigationController?.pushViewController(articleListVC, animated: true)
        }
        
    }
}
