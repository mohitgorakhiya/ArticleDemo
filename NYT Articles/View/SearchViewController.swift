//
//  SearchViewController.swift
//  NYT Articles
//
//  Created by Mohit Gorakhiya on 7/3/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = Constant.SearchArticlesText
    }
    
    @IBAction func searchClicked(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        let searchText = self.searchField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        if searchText.isEmpty
        {
            self.displayMessageAlertWithTitle(alertTitle: Constant.AlertTitle, withTitle: Constant.SearchBlankMessage)
            return
        }
        
        let articleListVC = self.storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.ArticlesListViewController.rawValue) as! ArticlesListViewController
        articleListVC.viewModel.articleType = ArticleType.Search
        articleListVC.viewModel.searchText = searchText
        self.navigationController?.pushViewController(articleListVC, animated: true)
    }

}

extension SearchViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
