//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

/// 链表节点
class LinkNode {
    var val: Int
    
    var prev: LinkNode?
    
    var next: LinkNode?
    
    init(_ val: Int) {
        self.val = val
        self.prev = nil
        self.next = nil
    }
}

/// 链表
class LinkList {
    var head: LinkNode?
    
    var tail: LinkNode?
    
    var count: Int = 0
}

/// 插入节点
func insertNode(val: Int, index:Int, list: LinkList) {
    let insertNode = LinkNode(val)
    if list.count == 0 {
        /// 空链表添加节点
        list.head = insertNode
        list.tail = insertNode
    } else if list.count < index {
        /// 插入位置不存在 插入尾节点
        list.tail?.next = insertNode
        insertNode.prev = list.tail
        list.tail = insertNode
    } else {
        /// 插入指定位置
        var searchNode = list.head
        var num = 0
        while num == list.count {
            searchNode = searchNode?.next
            num += 1
        }
        let temp = searchNode?.next
        searchNode?.next = insertNode
        insertNode.prev = searchNode
        insertNode.next = temp
        temp?.prev = insertNode
    }
    list.count += 1
}

/// 删除节点
func removeNode(val: Int, list: LinkList) {
    var removeNode = list.head
    while removeNode != nil, removeNode!.val == val {
        removeNode = removeNode?.next
    }
    if removeNode != nil {
        if list.count == 1 {
            /// 删除的节点为头结点和尾节点
            
        } else if list.count == 2 {
            if removeNode === list.head {
                /// 删除的节点为头结点
                list.head = list.tail
                list.tail?.prev = nil
            } else {
                /// 删除的节点为尾节点
                list.tail = list.head
                list.head?.next = nil
            }
        } else {
            /// 删除的节点为中间节点
            let prevNode = removeNode?.prev
            let nextNode = removeNode?.next
            prevNode?.next = nextNode
            nextNode?.prev = prevNode
        }
        removeNode?.prev = nil
        removeNode?.next = nil
        list.count -= 1
    }
}
