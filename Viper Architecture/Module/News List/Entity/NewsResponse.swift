//
//  NewsResponse.swift
//  Viper Architecture
//
//  Created by Minata on 15/12/2023.
//

import Foundation

struct NewsResponse: Codable, Equatable {
    
    let status: String?
    let results: [NewsListEntity]?
    
}
