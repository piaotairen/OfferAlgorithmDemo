//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

/// 会议时间的类
public class MeetingTime {
    
    public var start: Int
    
    public var end: Int
    
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

/// 会议时间重叠，则进行合并
func merge(meetingTimes: [MeetingTime]) -> [MeetingTime] {
    /// 处理特殊情况
    guard meetingTimes.count > 1 else {
        return meetingTimes
    }
    
    /// 排序
    var meetingTimes = meetingTimes.sorted {
        if $0.start != $1.start {
            return $0.start < $1.start
        } else {
            return $0.end < $1.end
        }
    }
    
    /// 新建结果数组
    var res = [MeetingTime]()
    res.append(meetingTimes[0])
    
    /// 遍历排序后的原数组，并与结果数组归并
    for i in 1..<meetingTimes.count {
        let last = res[res.count - 1]
        let current = meetingTimes[i]
        if current.start > last.end {
            res.append(current)
        } else {
            last.end = max(last.end, current.end)
        }
    }
    
    return res
}

