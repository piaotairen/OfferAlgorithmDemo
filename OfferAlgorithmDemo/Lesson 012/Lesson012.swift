//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation


/// Feed流中的新闻Model
public class News {
    
    public var text = ""
    
    public var time = Date().timeIntervalSince1970
    
    public init(time: TimeInterval) {
        self.time = time
    }
    
    public func compareDate(_ other: News) -> Int {
        return time < other.time ? -1 : 0
    }
}

extension Array {
    func indexForInsertingObject(object: AnyObject, compara: (_ a: AnyObject, _ b: AnyObject) -> Int) -> Int {
        var left = 0
        var right = self.count
        var mid = 0
        
        while left < right {
            mid = (right - left) / 2 + left
            
            if compara(self[mid] as AnyObject, object) < 0 {
                left = mid + 1
            } else {
                right = mid
            }
        }
        
        return left
    }
}

/// 将新闻插入Feeds流中
func newsSearchTest() {
    let now = Date().timeIntervalSince1970
    var news = [News(time: now + 1), News(time: now + 10), News(time: now + 100), News(time: now + 1000)]
    let insertObj = News(time: now + 11)
    let insertIdx = news.indexForInsertingObject(object: insertObj) { (a, b) -> Int in
        let newsA = a as! News
        let newsB = b as! News
        return newsA.compareDate(newsB)
    }
    news.insert(insertObj, at: insertIdx)
}
