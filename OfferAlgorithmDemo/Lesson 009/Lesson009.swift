//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

/// Swift中实现二分搜索
///
/// - Parameters:
///   - nums: 是一个升序的数组
///   - target: 搜索值
/// - Returns: 是否搜索到
/// - Note: 注意两个细节：
///     1 middle被定义在while循环外面，每次重新赋值。如果定义在里面，则每次都要给middle分配内存空间，造成不必要的浪费。
///     2 middle = (right - left) / 2 + left 不能写成 middle = (right + left) / 2 因为当数组非常大时，right + left就会非常大，造成溢出。
func binarySearch(_ nums: [Int], _ target: Int) -> Bool {
    var left = 0, middle = 0, right = nums.count - 1
    
    while left <= right {
        middle = (right - left) / 2 + left
        if nums[middle] == target {
            return true
        } else if nums[middle] < target {
            left = middle + 1
        } else {
            right = middle - 1
        }
    }
    return false
}

/// 递归实现二分搜索
func binarySearch(nums: [Int], target: Int) -> Bool {
    return binarySearch(nums: nums, target: target, left: 0, right: nums.count - 1)
}

func binarySearch(nums: [Int], target: Int, left: Int, right: Int) -> Bool {
    guard left <= right else {
        return false
    }
    
    let middle = (right - left) / 2 + left
    
    if nums[middle] == target {
        return true
    } else if nums[middle] < target {
        return binarySearch(nums: nums, target: target, left: middle + 1, right: right)
    } else {
        return binarySearch(nums: nums, target: target, left: left, right: middle - 1)
    }
}

