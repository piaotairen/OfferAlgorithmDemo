//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

func classicSort() {
    
    /// 插入排序
    func insertSort(array: inout [Int]) {
        for j in 1..<array.count {
            let key = array[j]
            var i = j - 1
            while i >= 0 && array[i] > key {
                array[i + 1] = array[i]
                i = i - 1
            }
            array[i + 1] = key
        }
    }
    
    /// 插入排序调用
    var cards = [5, 7, 18, 12, 49, 30, 3, 19, 99, 14]
    insertSort(array: &cards)
    print(cards)
    
    /// 希尔排序
    func shellSort(array: inout [Int]) {
        let length = array.count
        var h = 1
        let block = 3 /// 分块大小（大于1的值）
        
        /// h为分区后每块有多少个元素
        while (h < length / block) {
            h = block * h + 1; //通过循环算出h的取值，当分区大小为3时，h序列为1, 4, 13, 40, ...
        }
        
        while (h >= 1) {
            var j = 0, k = 0
            
            /// 分割后，产生n个子序列
            for n in 0..<h {
                /// 分别对每个子序列进行直接插入排序
                var i = n + h
                while i < length {
                    j = i - h
                    while j >= 0 && array[i] < array[j] {
                        j -= h
                    }
                    
                    let tmp = array[i]
                    k = i
                    while k > j + h {
                        array[k] = array[k-h]
                        k -= h
                    }
                    array[j+h] = tmp
                    i += h
                }
            }
            /// 直接插入排序完后，减少每块区里的元素。也就是说增大块区的数量，直到最后h=1(每块区里只有一个元素时，排序完成)
            h = h / block
        }
    }
    
    /// 调用Sell排序
    var numbers = [5, 7, 18, 12, 49, 30, 3, 19, 99, 14, 999, 245, 45, 99, 54, 24, 543, 874, 247]
    shellSort(array: &numbers)
    print(numbers)
    
    /// 选择排序
    func selectSort(array: inout [Int]) {
        let length = array.count
        for i in 0..<length-1 {
            /// 用来保存每一趟最小值数组的下标
            var minIndex = i
            /// 找出每一趟的最小值
            for j in i+1..<length {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            //将这趟的第一个数字和这趟的最小值交换位置
            (array[i], array[minIndex]) = (array[minIndex], array[i])
        }
    }
    
    /// 调用选择排序
    var prices = [5, 7, 18, 12, 49, 30, 3, 19, 99, 14, 999, 245, 45, 99, 54, 24, 543, 874, 247]
    selectSort(array: &prices)
    print(prices)
    
    /// 最大堆排序
    func maxHeapify(array: inout [Int], index: Int) {
        let l = (index + 1)<<1 - 1
        let r = (index + 1)<<1
        var largest = index
        if l < array.count && array[l] > array[index] {
            largest = l
        }
        if r < array.count && array[r] > array[largest] {
            largest = r
        }
        if largest != index {
            let temp = array[largest]
            array[largest] = array[index]
            array[index] = temp
            maxHeapify(array: &array, index: largest)
        }
    }
    
    /// 建立最大堆
    func buildMaxHeap(array: inout [Int]) {
        for index in 1...array.count / 2 {
            maxHeapify(array: &array, index: array.count / 2 - index)
        }
    }
    
    /// 最大堆排序调用
    var heapArray = [16, 4, 10, 14, 7, 9, 3, 2, 8, 1];
    print(heapArray)
    buildMaxHeap(array: &heapArray)
    print(heapArray)
    
    /// 冒泡排序
    func bubbleSort(array: inout [Int]) {
        let length = array.count - 1
        for i in 0..<length {
            /// 每一次循环找出最大值
            for j in 0..<length-i {
                if array[j] > array[j + 1] {
                    /// 如果前面的数比后面的数大就交换它们的位置
                    (array[j], array[j + 1]) = (array[j + 1], array[j])
                }
            }
        }
    }
    
    /// 冒泡排序调用
    var bubbleArray = [16, 4, 10, 14, 7, 9, 3, 2, 8, 1];
    bubbleSort(array: &bubbleArray)
    print(bubbleArray)
    
    /// 快速排序
    ///
    /// - Parameter A: 排序数组
    func quickSort(array: inout [Int], p: Int, r: Int) {
        if p < r {
            let q = partition(array: &array, p: p, r: r)
            quickSort(array: &array, p: p, r: q - 1)
            quickSort(array: &array, p: q + 1, r: r)
        }
    }
    
    /// 快速排序 以哨兵分割
    /// 数组划分，找到小标q A[p..r]为A[p..q-1]和A[q+1..r],使得A[p..q-1]中的每一个元素小于等于A[q],而A[q]小于等于A[q+1..r]中的每个元素
    ///
    /// - Parameter A: 排序的数组
    /// - Parameter p: 排序开始位置
    /// - Parameter r: 排序结束位置
    /// - Returns: 返回数组划分的小标q
    func partition(array: inout [Int], p: Int, r: Int) -> Int {
        let x = array[r]
        var i = p
        for j in p..<r {
            if array[j] <= x {
                i += 1
                // 第i个元素和第j个元素交换
                let temp = array[j]
                array[j] = array[i - 1]
                array[i - 1] = temp
            }
        }
        // 第i + 1个元素和最后一个元素交换
        let temp = array[i]
        array[i] = array[r]
        array[r] = temp
        return i
    }
    
    /// 快速排序的调用
    var quickSortArray = [2, 8, 7, 1, 3, 5, 6, 4, 80, 11, 29]
    print(quickSortArray)
    quickSort(array: &quickSortArray, p: 0, r: quickSortArray.count - 1)
    print(quickSortArray)
    
    /// 归并排序 分治法递归调用 (尚未考虑数组count为奇数情况)
    func mergeSort(array: inout [Int], n: Int) {
        if n * 2 >  array.count {
            return
        }
        let mergeCount = ((array.count % 2) == 0) ?  (array.count / (2 * n)) : ((array.count + 1) / (2 * n))
        for i in 0..<mergeCount {
            merge(array: &array, p: (i * n * 2), q: ((i * 2 + 1) * n - 1), r: ((i + 1) * n * 2 - 1))
        }
        mergeSort(array: &array, n: n * 2)
    }
    
    /// 归并排序合并子序列 (A[p, q],A[q + 1, r]都已排好序)
    func merge(array: inout [Int], p: Int, q: Int, r: Int) {
        let n1 = q - p
        let n2 = r - q - 1
        var L:Array<Int> = []
        var R:Array<Int> = []
        for i in 0...n1 {
            L.append(array[p + i])
        }
        L.append(NSIntegerMax)
        for j in 0...n2 {
            R.append(array[q + j + 1])
        }
        R.append(NSIntegerMax)
        var i = 0
        var j = 0
        for k in p...r {
            if L[i] <= R[j] {
                array[k] = L[i]
                i = i + 1
            } else {
                array[k] = R[j]
                j = j + 1
            }
        }
    }
    
    /// 归并排序的调用
    var mergeArray = [12, 14, 45, 47, 31, 16, 93, 36]
    mergeSort(array: &mergeArray, n: 1)
    print(mergeArray)
    
    /// 基数排序 （又称桶排序）
    func cardinalitySort(array: inout [Int], max: Int) {
        /// 代表位数对应的数：个位、十位、百位、千位..直到小于max的最大位数
        var n = 1
        /// 保存每一位排序后的结果用于下一位的排序输入
        var k = 0
        let length = array.count
        
        /// 排序桶用于保存每次排序后的结果，这一位上排序结果相同的数字放在同一个桶里
        var bucket = Array(repeating: Array(repeating: 0, count: length), count: 10)
        /// 用于保存每个桶里有多少个数字
        var order = Array(repeating: 0, count: length)
        
        while n < max {
            /// 将数组array里的每个数字放在相应的桶里
            for num in array {
                let digit = (num / n) % 10
                bucket[digit][order[digit]] = num
                order[digit] += 1
            }
            
            /// 将前一个循环生成的桶里的数据覆盖到原数组中用于保存这一位的排序结果
            for i in 0..<length {
                /// 这个桶里有数据，从上到下遍历这个桶并将数据保存到原数组中
                if order[i] != 0 {
                    for j in 0..<order[i] {
                        array[k] = bucket[i][j]
                        k += 1
                    }
                }
                /// 将桶里计数器置0，用于下一次位排序
                order[i] = 0
            }
            
            /// 扩大位数，如从个位扩大到十位
            n *= 10
            /// 将k置0，用于下一轮保存位排序结果
            k = 0
        }
    }
    
    /// 基数排序调用
    var bucketArray = [2, 5, 3, 0, 2, 3, 0, 3, 12, 44, 99, 43, 3, 47]
    cardinalitySort(array: &bucketArray, max: 2)
    print(bucketArray)
    
    /// 计数排序 (线性时间排序)
    func countingSort(A: inout [Int], B: inout [Int], k: Int) {
        var C: [Int] = []
        for _ in 0...k {
            C.append(0)
        }
        for j in 0..<A.count {
            C[A[j]] = C[A[j]] + 1
        }
        // C[i] now contains the number of elements equal to i.
        for i in 1...k {
            C[i] = C[i] + C[i - 1]
        }
        // C[i] now contains the number of elements less than or equal to i.
        for j in 1...A.count {
            let revert = A.count - j
            B[C[A[revert]]] = A[revert]
            C[A[revert]] = C[A[revert]] - 1
        }
    }
    
    /// 计数排序调用
    var countingSortA = [2, 5, 3, 0, 2, 3, 0, 3]
    var outPutB: [Int] = Array(repeating: 0, count: countingSortA.count + 1)
    countingSort(A: &countingSortA, B: &outPutB, k: 5)
    print(outPutB)
    
    // 桶排序
    func bucketSort(A:inout [Float]) {
        let n = A.count
        var B: [Float] = []
        for _ in 0..<n {
            B.append(0)
        }
        for i in 1...n {
            //        inset A[i] into list B[「n * A[i]」]
        }
        for i in 0..<n {
            //        sort list B[i] with insertion sort
        }
        //    contatenate the lists B[0], B[1],...,B[n - 1] together in order
    }
    
}
