//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

/// 二分搜索判断第一个崩溃的版本
func findFirstBadVersion(n: Int) -> Int {
    guard n >= 1 else {
        return -1
    }
    
    var left = 1, right = n, mid = 0
    
    while left < right {
        mid = (right - left) / 2 + left
        if isBadVersion(version: mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    
    return left
}

/// 判断一个版本是否崩溃
func isBadVersion(version: Int) -> Bool {
    return true
}

/// 搜索旋转有序数组 
func search(nums: [Int], target: Int) -> Int {
    var (left, mid, right) = (0, 0, nums.count - 1)
    
    while left <= right {
        mid = (right - left) / 2 + left
        
        if nums[mid] == target {
            return mid
        }
        
        if nums[mid] >= nums[left] {
            if nums[mid] > target && target >= nums[left] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        } else {
            if nums[mid] < target && target <= nums[right] {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
    
    return -1
}


