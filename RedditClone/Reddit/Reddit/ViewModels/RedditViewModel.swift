//
//  RedditViewModel.swift
//  RedditClone
//
//  Created by William Huynh on 12/22/20.
//

import Foundation

class RedditViewModel {
    
    private var redditStore: RedditStore!
    
    init(redditStore: RedditStore) {
        self.redditStore = redditStore
    }
    
    func loadReddits(subRedditTitle: String = "", completion: @escaping  (Bool) -> Void) {
        redditStore.fetchRedditMainPosts(subRedditString: "r/\(subRedditTitle)/") { (success) in
            completion(success)
        }
    }
    
    func getNumberOfReddits() -> Int {
        return redditStore.reddits.count
    }
    
    func getRedditTitle(atRow row: Int) -> String {
        return redditStore.reddits[row].title
    }
    
    func getSubRedditTitle(atRow row: Int) -> String {
        return redditStore.reddits[row].subreddit_name_prefixed
    }
    
    func getSubRedditLink(atRow row: Int) -> String {
        return "https://www.reddit.com" + redditStore.reddits[row].permalink
    }
}
