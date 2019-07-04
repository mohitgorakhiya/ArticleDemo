//
//  ArticlesListViewController.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class ArticlesListViewController: BaseViewController {

    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listTableView.register(UINib.init(nibName: "LoadMoreCell", bundle:nil), forCellReuseIdentifier: "LoadMoreCell")
        self.listTableView.register(UINib.init(nibName: "ArticleListCell", bundle:nil), forCellReuseIdentifier: "ArticleListCell")
   
        self.listTableView.separatorStyle = .none
        self.listTableView.tableFooterView = UIView(frame: .zero)
        if #available(iOS 10.0, *) {
            self.listTableView.refreshControl = refreshControl
        } else {
            self.listTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshArticleData(_:)), for: .valueChanged)

        self.setPageTitle()
        self.displayIndicatorView(isHide: false)
        self.fetchArticles()
    }
    
    func setPageTitle()
    {
        if viewModel.articleType == ArticleType.MostEmailed
        {
            self.title = "\(Constant.MostEmailedText) \(Constant.ArticlesText)"
        }
        else if viewModel.articleType == ArticleType.MostShared
        {
            self.title = "\(Constant.MostSharedText) \(Constant.ArticlesText)"
        }
        else if viewModel.articleType == ArticleType.MostViewed
        {
            self.title = "\(Constant.MostViewedText) \(Constant.ArticlesText)"
        }
        else
        {
            self.title = Constant.ArticlesText
        }
    }
    
    lazy var viewModel: ArticlesListViewModel = {
        return ArticlesListViewModel.init(delegate: self)
    }()
    
    // it will refresh data from page 0
    @objc private func refreshArticleData(_ sender: Any) {
        
        if viewModel.isDataLoading
        {
            return
        }
        viewModel.isMoreDataAvailable = true
        viewModel.pageNumber = 0
        fetchArticles()
    }
    
    func fetchArticles()
    {
        if !self.CheckForInternetConnection()
        {
            self.displayIndicatorView(isHide: true)
            
            self.displayMessageAlertWithTitle(alertTitle: Constant.AlertTitle, withTitle: Constant.NoInternetMessage)
            return
        }
        self.viewModel.fetchArticles()
    }
    
    func displayIndicatorView(isHide: Bool)
    {
        if isHide
        {
            self.progressView.isHidden = true
            self.indicatorView.stopAnimating()
        }
        else
        {
            self.progressView.isHidden = false
            self.indicatorView.startAnimating()
        }
    }
}

extension ArticlesListViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell", for: indexPath) as? LoadMoreCell else {
                fatalError("The dequeued cell is not an instance of LoadMoreCell.")
            }
            
            cell.indicatorView.hidesWhenStopped = true
            cell.indicatorView.startAnimating()
            
            return cell
        }
        let articleListCell = tableView.dequeueReusableCell(withIdentifier: "ArticleListCell", for: indexPath) as! ArticleListCell
        articleListCell.configure(articlePresentable: self.viewModel.articlesList[indexPath.row])
        articleListCell.selectionStyle = .none
        return articleListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

extension ArticlesListViewController: UIScrollViewDelegate
{
    //Pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if viewModel.articleType == ArticleType.Search && viewModel.isMoreDataAvailable
        {
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if distanceFromBottom <= height {
                if !viewModel.isDataLoading
                {
                    viewModel.isDataLoading = true
                    viewModel.pageNumber = viewModel.pageNumber + 1
                    self.fetchArticles()
                }
            }
            
        }
    }
}

extension ArticlesListViewController: ArticlesListViewModeldDelegate
{
    func updateUIAfterFetchData() {
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.displayIndicatorView(isHide: true)
            self.listTableView.reloadData()
            
            if self.viewModel.articlesList.count == 0
            {
                self.displayMessageAlertWithTitle(alertTitle: Constant.AlertTitle, withTitle: Constant.NoDataFound)
            }
        }
        self.viewModel.isDataLoading = false
    }
    
    func validationFailure(title: String, message: String) {
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.displayIndicatorView(isHide: true)
            self.displayMessageAlertWithTitle(alertTitle: title, withTitle: message)
        }
        self.viewModel.isDataLoading = false
    }
}
