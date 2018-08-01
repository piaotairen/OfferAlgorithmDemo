//
//  Lesson005.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/7/31.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

/// 链表节点
class ListNode {
    var val: Int
    var next: ListNode?
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

/// 链表
class List {
    var head: ListNode?
    var tail: ListNode?
    
    /// 尾插法
    ///
    /// - Parameter val: 插入节点
    func appendToTail(_ val: Int) {
        if tail == nil {
            tail = ListNode(val)
            head = tail
        } else {
            tail?.next = ListNode(val)
            tail = tail?.next
        }
    }
    
    /// 头插法
    ///
    /// - Parameter val: 插入节点
    func appendToHead(_ val: Int) {
        if head == nil {
            head = ListNode(val)
            tail = head
        } else {
            let temp = ListNode(val)
            temp.next = head
            head = temp
        }
    }
    
    /// 例如：1->5->3->2->4->2，给定x=3，则要返回1->2->2->5->3->4。
    
    /// 获取比x小的节点组成的链表
    func getLeftList(_ head: ListNode?, _ x: Int) -> ListNode? {
        let dummy = ListNode(0)
        var pre = dummy, node = head
        
        while node != nil {
            if node!.val < x {
                pre.next = node
                pre = node!
            }
            node = node?.next
        }
        
        /// 防止构成环
        pre.next = nil
        return dummy.next
    }
    
    /// 最终要返回的链表
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        /// 引入dummy节点
        let prevDummy = ListNode(0), postDummy = ListNode(0)
        var prev = prevDummy, post = postDummy
        
        var node = head
        
        /// 用尾插法处理左边和右边
        while node != nil {
            if node!.val < x {
                prev.next = node
                post = node!
            } else {
                post.next = node
                post = node!
            }
            node = node?.next
        }
        
        /// 防止构成环
        post.next = nil
        /// 左右拼接
        prev.next = postDummy.next
        
        return prevDummy.next
    }
    
    /// 检测链表是否有环
    func hasCycle(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head
        
        while fast != nil && fast!.next != nil {
            slow = slow!.next
            fast = fast?.next?.next
            
            if slow === fast {
                return true
            }
        }
        
        return false
    }
    
    /// 删除链表中倒数第n个节点
    func removeNthFromEnd(head: ListNode?, _ n: Int) -> ListNode? {
        guard let head = head else {
            return nil
        }
        
        let dummy = ListNode(0)
        dummy.next = head
        var prev: ListNode? = dummy
        var post: ListNode? = dummy
        
        /// 设置后一个节点的初始位置
        for _ in 0..<n {
            if post == nil {
                break
            }
            post = post!.next
        }
        
        /// 同时移动前后两节点
        while post != nil && post!.next != nil {
            prev = prev?.next
            post = post?.next
        }
        
        /// 删除节点
        prev?.next = prev?.next?.next
        return dummy.next
    }
    
}
