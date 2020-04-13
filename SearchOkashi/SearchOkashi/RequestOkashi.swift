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
    
    var okashiList : [(name:String, maker:String, link:URL, image:URL)] = []
    
    // 引数keywordはUISearchBarに入力する検索したいキーワード
    func searchOkashi(keyword : String , completion: @escaping ([(name:String, maker:String, link:URL, image:URL)]) -> Void){
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
            // { response in ...} の部分は完了ハンドラとして渡される
            // その完了ハンドラが渡されるのは通信完了後
            // しかし、return okashiListが実行されるのは通信完了前
            // だから、結果が[]やnillになる
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
                self.okashiList.removeAll()
                for item in items {
                    guard let name:String = item.name, let maker:String = item.maker, let link:URL = item.url, let image = item.image else {
                        return
                    }
                    let okashiTuple = (name, maker, link, image)
                    self.okashiList.append(okashiTuple)
                }
                
                //元の非同期処理の完了ハンドラの中で自前の完了ハンドラを呼び出す
                completion(self.okashiList)
                
            case .failure(let error):
                print(error)
                
            }
            
        }
        
    }

}
