//
//  ResponseOkashi.swift
//  SearchOkashi
//
//  Created by 工藤海斗 on 2020/03/24.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import Foundation

struct ItemJson : Codable {
    let name : String
    let maker : String
    let url : URL
    let image : URL?
}

struct ResultJson : Codable {
    let item : [ItemJson]?
}
