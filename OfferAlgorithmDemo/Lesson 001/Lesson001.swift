//
//  Lesson001.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/7/30.
//  Copyright © 2018年 Cobb. All rights reserved.
//
//  -------------------------------------------------------------
//  Lesson001 --> 二元查找树的后序遍历
//  Verify whether a squence of integers are the post order traversal
//  of a binary search tree (BST)
//  Input: squence - the squence of integers
//          length  - the length of squence
//  Return: return ture if the squence is traversal result of a BST,
//          otherwise, return false
//  -------------------------------------------------------------
//

import Cocoa

class Lesson001: NSObject {
    
    static func test() {
        
        /// 判断一个输入的数组是否是一个二元查找树的后序遍历
        ///
        /// - Parameters:
        ///   - squence: 输入的数组
        ///   - length: 数组的长度
        /// - Returns: 返回是否成立
        func verifySquenceOfBST(sequence: [Int], start: Int, end: Int) -> Bool {
            guard sequence.count > 0, end > start, sequence.count > end else {
                return false
            }
            
            // root of a BST is at the end of post order traversal squence
            let root = sequence[end]
            
            // the nodes in left sub-tree are less than the root
            var middleIndex = 0
            while middleIndex < end - 1 {
                if sequence[middleIndex] > root {
                    break
                }
                middleIndex += 1
            }
            
            // the nodes in the right sub-tree are greater than the root
            for j in middleIndex..<end - 1 {
                if sequence[j] < root {
                    return false
                }
            }
            
            // verify whether the left sub-tree is a BST
            var left = true
            if middleIndex - 1 > start {
                left = verifySquenceOfBST(sequence: sequence, start: start, end: middleIndex - 1)
            }
            
            // verify whether the right sub-tree is a BST
            var right = true
            if middleIndex < end - start - 1 {
                right = verifySquenceOfBST(sequence: sequence, start: middleIndex, end: end - start - 1)
            }
            
            return left && right
        }
        
        let sequence = [5, 7, 6, 9, 11, 10, 8]
        let result = verifySquenceOfBST(sequence: sequence, start: 0, end: sequence.count - 1)
        print("\(sequence) 是否是一个二元查找树的后序遍历 == \(result)")
    }
}
