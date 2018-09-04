//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

class TreeInvert {
    
    // 得到二叉树的镜像  —— 递归的方式
    func mirror(root: TreeNode?) {
        guard let root = root else {
            return
        }
        if root.left == nil && root.right == nil {
            return
        }
        (root.left, root.right) = (root.right, root.left)
        mirror(root: root.left)
        mirror(root: root.right)
    }
    
    // 得到二叉树的镜像 —— 不使用递归
    func mirrorNotRecursive(root: TreeNode?) {
        guard let root = root else {
            return
        }
        var stack: [TreeNode] = []
        stack.append(root)
        while stack.count != 0 {
            let node = stack.removeFirst()
            (node.left, node.right) = (node.right, node.left)
            
            if node.right != nil {
                stack.append(node.right!)
            }
            if node.left != nil {
                stack.append(node.left!)
            }
        }
    }
    
    // 层次遍历二叉树
    func levelTraverse(root: TreeNode?) {
        guard let root = root else {
            return
        }
        var stack: [TreeNode] = []
        stack.append(root)
        while stack.count != 0 {
            let node = stack.removeFirst()
            print("var == \(node.val) *")
            if node.left != nil {
                stack.append(node.left!)
            }
            if node.right != nil {
                stack.append(node.right!)
            }
        }
    }
    
    /// 翻转二叉树
    func invertTree(root: TreeNode?) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        root.left = invertTree(root: root.left)
        root.right = invertTree(root: root.right)
        (root.left, root.right) = (root.right, root.left)
        return root
    }
}
