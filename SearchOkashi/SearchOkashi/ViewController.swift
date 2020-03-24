//
//  ViewController.swift
//  SearchOkashi
//
//  Created by 工藤海斗 on 2020/03/23.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchText: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var itemJson : [ItemJson]!
    private var resultJson : ResultJson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchText.delegate = self
        searchText.placeholder = "お菓子の名前を入力してください"
        
        
    }
    
    
    // 検索ボタンクリック時に呼ばれるdelegateメソッド
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // キーボードを閉じる
        view.endEditing(true)
        
        guard let searchWord = searchBar.text else {
            return
        }
        print(searchWord)
        searchOkashi(keyword: searchWord)
    }
    
    // 引数keywordはUISearchBarに入力する検索したいキーワード
    func searchOkashi(keyword : String){
        // 全角文字をエンコードする
        guard let keywordEncode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        // リクエストURL生成
        guard let requestURL = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keywordEncode)&max=10&order=r") else {
            return
        }
        print(requestURL)
        
        AF.request(requestURL, method: .get, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let value):
                guard let data = response.data else {return}
                let decoder = JSONDecoder()
                
                guard let okashi = try? decoder.decode(ResultJson.self, from: data) else {return}
                print(okashi)
                
                
                
            case .failure(let error):
                print(error)
                
            }
        }

    }

}

