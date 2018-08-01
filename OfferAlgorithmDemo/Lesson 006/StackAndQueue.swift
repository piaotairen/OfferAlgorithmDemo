//
//  StackAndQueue.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/7/31.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

/// 栈是后进先出的结构 遵循如下协议 关注几个基本操作：push、pop、isEmpty、peek、size
protocol Stack {
    /// 持有的元素类型
    associatedtype Element
    
    /// 是否为空
    var isEmpty: Bool { get }
    
    /// 栈的大小
    var size: Int { get }
    
    /// 栈顶元素
    var peek: Element? { get }
    
    /// 进栈
    mutating func push(_ newElement: Element)
    
    /// 出栈
    mutating func pop() -> Element?
}

/// 遵循Stack协议的Int数据类型的栈
struct IntStack: Stack {
    
    typealias Element = Int
    
    private var stack = [Element]()
    
    var isEmpty: Bool {
        return stack.isEmpty
    }
    
    var size: Int {
        return stack.count
    }
    
    var peek: Int? {
        return stack.last
    }
    
    mutating func push(_ newElement: Int) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Int? {
        return stack.popLast()
    }
}

/// 遵循Stack协议的Any数据类型的栈
struct AnyStack: Stack {

    typealias Element = Any
    
    private var stack = [Element]()
    
    var isEmpty: Bool {
        return stack.isEmpty
    }
    
    var size: Int {
        return stack.count
    }
    
    var peek: Any? {
        return stack.last
    }
    
    mutating func push(_ newElement: Any) {
        stack.append(newElement)
    }
    
    mutating func pop() -> Any? {
        return stack.popLast()
    }
}

/// 队列是先进先出的结构，关注：enqueue、dequeue、isEmpty、peek、size
protocol Queue {
    
    /// 持有的元素类型
    associatedtype Element
    
    /// 是否为空
    var isEmpty: Bool { get }
    
    /// 栈的大小
    var size: Int { get }
    
    /// 队首元素
    var peek: Element? { get }
    
    /// 入队
    mutating func enqueue(_ newElement: Element)
    
    /// 出队
    mutating func dequeue() -> Element?
}

/// 遵循Queue协议的Int类型的队列
struct IntQueue: Queue {
    
    typealias Element = Int
    
    private var left = [Element]()
    
    private var right = [Element]()
    
    var isEmpty: Bool {
        return left.isEmpty && right.isEmpty
    }
    
    var size: Int {
        return left.count + right.count
    }
    
    var peek: Int? {
        return left.isEmpty ? right.first : left.last
    }
    
    mutating func enqueue(_ newElement: Int) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Int? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

/// 遵循Queue协议的Any类型的队列
struct AnyQueue: Queue {
    
    typealias Element = Any
    
    private var left = [Element]()
    
    private var right = [Element]()
    
    var isEmpty: Bool {
        return left.isEmpty && right.isEmpty
    }
    
    var size: Int {
        return left.count + right.count
    }
    
    var peek: Any? {
        return left.isEmpty ? right.first : left.last
    }
    
    mutating func enqueue(_ newElement: Any) {
        right.append(newElement)
    }
    
    mutating func dequeue() -> Any? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

/// 用栈实现队列
struct MyQueue {
    
    var stackA: AnyStack
    
    var stackB: AnyStack
    
    var isEmpty: Bool {
        return stackA.isEmpty && stackB.isEmpty
    }
    
    var peek: Any? {
        mutating get {
            shift()
            return stackB.peek
        }
    }
    
    var size: Int {
        get {
            return stackA.size + stackB.size
        }
    }
    
    init() {
        stackA = AnyStack()
        stackB = AnyStack()
    }
    
    mutating func enqueue(object: Any) {
        stackA.push(object)
    }
    
    mutating func dequeue() -> Any? {
        shift()
        return stackB.pop()
    }
    
    fileprivate mutating func shift() {
        if stackB.isEmpty {
            while !stackA.isEmpty {
                stackB.push(stackA.pop()!)
            }
        }
    }
}

/// 用队列实现栈
struct MyStack {
    
    var queueA: AnyQueue
    
    var queueB: AnyQueue
    
    init() {
        queueA = AnyQueue()
        queueB = AnyQueue()
    }
    
    var isEmpty: Bool {
        return queueA.isEmpty && queueB.isEmpty
    }
    
    var peek: Any? {
        mutating get {
            shift()
            let peekObj = queueA.peek
            queueB.enqueue(queueA.dequeue()!)
            swap()
            return peekObj
        }
    }
    
    var size: Int {
        return queueA.size
    }
    
    mutating func push(object: Any) {
        queueA.enqueue(object)
    }
    
    mutating func pop() -> Any? {
        shift()
        let popObject = queueA.dequeue()
        swap()
        return popObject
    }
    
    private mutating func shift() {
        while queueA.size != 1 {
            queueB.enqueue(queueA.dequeue()!)
        }
    }
    
    private mutating func swap() {
        (queueA, queueB) = (queueB, queueA)
    }
}

class Lesson006 {
    
    /// 给出一个文件的绝对路径，要求将其简化。举一个例子，路径是"/home/"，简化后为"/home"；路径是"/a/./b/../../c/"，简化后为"/c"。
    static func simplifyPath(path: String) -> String {
        /// 用数组实现栈的功能
        var pathStack = [String]()
        
        /// 拆分源路径
        let paths = path.components(separatedBy: "/")
        
        for path in paths {
            /// 对于"."直接跳过
            guard path != "." else {
                continue
            }
            
            /// 对于".."使用pop操作
            if path == ".." {
                if pathStack.count > 0 {
                    pathStack.removeLast()
                }
            } else if path != "" {
                /// 对于空数组的情况
                pathStack.append(path)
            }
        }
        
        /// 将栈中的内容转化为优化后的新路径
        let res = pathStack.reduce("") { total, dir in "\(total)/\(dir)" }
        
        /// 注意空路径的结果是"/"
        return res.isEmpty ? "/" : res
    }
    
    static func test() {
        let input = "/a/./b/../../c/"
        let res = simplifyPath(path: input)
        print("路径\(input)转换后为\(res)")
    }

}

