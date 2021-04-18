//
//  NewsModel.swift
//  CryptoPricePro
//
//  Created by Kinjal Pipaliya on 20/07/20.
//  Copyright © 2020 Kinjal Pipaliya. All rights reserved.
//

import Foundation
struct NewsModel: Codable {
    
    var status: String = ""
    var articles: [Article]
}

struct Article: Codable {
    var author: String
    var title: String
    var url: String
    var urlToImage: String
}
