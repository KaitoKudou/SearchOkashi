//
//  RequestOkashi.swift
//  SearchOkashi
//
//  Created by 工藤海斗 on 2020/03/25.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import Foundation
import Alamofire

class RequestOkashi{
    
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
            case .success( _):
                guard let data = response.data else {return}
                let decoder = JSONDecoder()
                
                guard let okashi = try? decoder.decode(ResultJson.self, from: data) else {
                    return
                }
                guard let items = okashi.item else {
                    return
                }
                for item in items {
                    guard let name:String = item.name, let maker:String = item.maker, let link:URL = item.url, let image = item.image else {
                        return
                    }
                    print("お菓子の名前:\(name)")
                    print("メーカー:\(maker)")
                    print("詳細ページリンク:\(link)")
                    print("お菓子画像のURL:\(image)")
                }
                print(items.count)
                
            case .failure(let error):
                print(error)
                
            }
        }

    }

}
