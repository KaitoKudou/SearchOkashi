//
//  ViewController.swift
//  SearchOkashi
//
//  Created by 工藤海斗 on 2020/03/23.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {

    @IBOutlet weak var searchText: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var request = RequestOkashi()
    var okashiList : [(name:String, maker:String, link:URL, image:URL)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchText.delegate = self
        searchText.placeholder = "お菓子の名前を入力してください"
        tableView.dataSource = self
    }
    
    // 検索ボタンクリック時に呼ばれるdelegateメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる
        view.endEditing(true)
        
        guard let searchWord = searchBar.text else {
            return
        }
        print(searchWord)
        
        request.searchOkashi(keyword: searchWord, completion: { okashiList in
            self.okashiList = okashiList
            print(self.okashiList)
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.okashiList.count)
        return okashiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "okashiCell", for: indexPath)
        return cell
    }

}

