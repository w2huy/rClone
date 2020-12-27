//
//  Reddit.swift
//  RedditClone
//
//  Created by William Huynh on 12/22/20.
//

import Foundation

class Reddit: Codable {
    var title: String
    var subreddit_name_prefixed: String
    var permalink: String
}

struct RedditPostData: Codable {
    let data: Reddit
}

struct RedditChildren: Codable {
    let children: [RedditPostData]
}

struct RedditData: Codable {
    let data: RedditChildren
}
