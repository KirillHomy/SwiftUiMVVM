//
//  ResponseModel.swift
//  SwiftUiMVVM
//
//  Created by Kirill Khomicevich on 21.12.2024.
//

import Foundation

struct ResponseModel: Decodable, Hashable {
    let articles: [Article]
}

struct Article: Decodable, Hashable {
    let author: String?
    let title: String?
}
