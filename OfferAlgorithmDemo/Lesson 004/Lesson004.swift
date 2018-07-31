//
//  Lesson004.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/7/31.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

func twoSum(nums: [Int], _ target: Int) -> Bool {
    var set = Set<Int>()
    
    for num in nums {
        if set.contains(target - num) {
            return true
        }
        
        set.insert(num)
    }
    
    return false
}
