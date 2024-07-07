//
//  PagingInfo.swift
//  Rick and Morty Revealed
//
//  Created by Grzegorz Janosz on 05/07/2024.
//

import Foundation

struct PaginationInfo: Decodable, Equatable, Sendable {
    var count: Int
    var pages: Int
    var next: URL?
    var prev: URL?
}

struct Pagination<T>: Decodable, Equatable, Sendable where T: Decodable & Equatable & Sendable {
    var info: PaginationInfo
    
    var results: [T]
}
