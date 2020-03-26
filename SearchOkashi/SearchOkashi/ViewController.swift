//
//  ViewController.swift
//  SearchOkashi
//
//  Created by 工藤海斗 on 2020/03/23.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit

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
        
        // 非同期処理の呼び出し
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
        
        // お菓子の名前をcellに表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "okashiCell", for: indexPath)
        cell.textLabel?.text = okashiList[indexPath.row].name
        
        // お菓子の画像をcellに表示
        if let imageData = try? Data(contentsOf: okashiList[indexPath.row].image){
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        return cell
    }

}

