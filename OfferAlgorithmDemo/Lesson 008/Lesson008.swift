//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

/// 归并排序
func mergeSort(_ array: [Int]) -> [Int] {
    var helper = Array(repeating: 0, count: array.count), array = array
    mergeSort(&array, &helper, 0, array.count - 1)
    return array
}

/// 递归调用的排序方法
func mergeSort(_ array: inout [Int], _ helper: inout [Int], _ low: Int, _ high: Int) {
    guard low < high else {
        return
    }
    
    let middle = (high - low) / 2 + low
    mergeSort(&array, &helper, low, middle)
    mergeSort(&array, &helper, middle + 1, high)
    merge(array: &array, &helper, low, middle, high)
}

/// 合并的逻辑
func merge( array: inout [Int], _ helper: inout [Int], _ low: Int, _ middle: Int, _ high: Int) {
    /// copy both halves into a helper array
    for i in low...high {
        helper[i] = array[i]
    }
    
    var helperLeft = low, helperRight = middle + 1, current = low
    
    /// iterate through helper array and copy the right one to original array
    while helperLeft <= middle && helperRight <= high {
        if helper[helperLeft] <= helper[helperRight] {
            array[current] = helper[helperLeft]
            helperLeft += 1
        } else {
            array[current] = helper[helperRight]
            helperRight += 1
        }
        current += 1
    }
    
    /// handle the rest
    guard middle - helperLeft >= 0 else {
        return
    }
    for i in 0...middle - helperLeft {
        array[current + i] = helper[helperLeft + i]
    }
}

/// 快速排序
func quickSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else {
        return array
    }
    let pivot = array[array.count / 2]
    let left = array.filter { $0 < pivot }
    let middle = array.filter { $0 == pivot }
    let right = array.filter { $0 > pivot }
    
    return quickSort(left) + middle + quickSort(right)
}

/// 测试
func mergeSortTest() {
    let array = [3, 54, 96, 25, 80, 48, 50, 25, 36, 99, 80, 88, 44, 5]
    print("归并排序前的数组为 \(array)")
    let sortArray = mergeSort(array)
    print("归并排序后的数组为 \(sortArray)")
    
    let array1 = [3, 54, 96, 25, 80, 48, 50, 25, 36, 99, 80, 88, 44, 5]
    print("快速排序前的数组为 \(array1)")
    let sortArray1 = quickSort(array1)
    print("快速排序后的数组为 \(sortArray1)")
}
