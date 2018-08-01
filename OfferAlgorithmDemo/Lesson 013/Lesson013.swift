//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation


/// 深度优先、广度优先搜索使用的节点
struct Node {
    
    var val: Int
    
    var visited: Bool = false
    
    var neighbors: [Node] = []
}

/// 查找匹配Node
///
/// - Parameter node: 匹配的Node
func visit(_ node: Node?) {
    if let node = node {
        print("\(node)")
    }
}

/// 深度优先搜索DFS在Swift中的实现
func dfs(_ root: Node?) {
    guard var root = root else {
        return
    }
    
    visit(root)
    root.visited = true
    
    for node in root.neighbors {
        if !node.visited {
            dfs(node)
        }
    }
}

/// 广度优先搜索BFS在Swift中的实现
func bfs(_ root: Node?) {
    var queue = [Node]()
    
    if let root = root {
        queue.append(root)
    }
    
    while !queue.isEmpty {
        var current = queue.removeFirst()
        
        visit(current)
        current.visited = true
        
        for node in current.neighbors {
            if !node.visited {
                queue.append(node)
            }
        }
    }
}

/// DFS实现搜索单个单词
func searchWord(_ board: [[Character]]) -> Bool {
    guard board.count > 0 && board[0].count > 0 else {
        return false
    }
    
    let (m, n) = (board.count, board[0].count)
    var visited = Array(repeating: Array(repeating: false, count: n), count: m)
    let wordContent = [Character]("crowd")
    
    for i in 0..<m {
        for j in 0..<n {
            if dfs(board, wordContent, m, n, i, j, &visited, 0) {
                return true
            }
        }
    }
    
    return false
}

/// 在矩阵指定字母的各个方向匹配单词
func dfs(_ board: [[Character]], _ wordContent: [Character], _ m: Int, _ n: Int, _ i: Int, _ j: Int, _ visited: inout [[Bool]], _ index: Int) -> Bool {
    if index == wordContent.count {
        return true
    }
    
    guard i >= 0 && i < m && j >= 0 && j < n else {
        return false
    }
    guard !visited[i][j] && board[i][j] == wordContent[index] else {
        return false
    }
    
    visited[i][j] = true
    
    if dfs(board, wordContent, m, n, i + 1, j, &visited, index + 1) || dfs(board, wordContent, m, n, i - 1, j, &visited, index + 1) || dfs(board, wordContent, m, n, i, j + 1, &visited, index + 1) || dfs(board, wordContent, m, n, i, j - 1, &visited, index + 1) {
        return true
    }
    
    visited[i][j] = false
    return false
}

/// DFS实现搜索多个单词
func findWord(_ board: [[Character]], _ dict: Set<String>) -> [String] {
    var res = [String]()
    
    let (m, n) = (board.count, board[0].count)
    
    let trie = _convertSetToTrie(dict)
    var visited = Array(repeating: Array(repeating: false, count: n), count: m)
    
    for i in 0..<m {
        for j in 0..<n {
            dfs(board, m, n, i, j, &visited, &res, trie, "")
        }
    }
    
    return res
}

/// 前缀树
struct Trie {
    
    /// 是否是某个单词的前缀
    ///
    /// - Parameter str: 校验的字符串
    /// - Returns: 返回Bool
    func prefixWith(_ str: String) -> Bool {
        return true
    }
    
    /// 是否是某个单词
    ///
    /// - Parameter str: 校验的字符串
    /// - Returns: 返回Bool
    func isWord(_ str: String) -> Bool {
        return true
    }
}

func _convertSetToTrie(_ dict: Set<String>) -> Trie {
    return Trie()
}

/// 在矩阵指定字母的各个方向匹配单词（带有前缀树的方式）
func dfs(_ board: [[Character]], _ m: Int, _ n: Int, _ i: Int, _ j: Int, _ visited: inout [[Bool]], _ res: inout [String], _ trie: Trie, _ str: String) {
    /// 越界处理
    guard i >= 0 && i < m && j >= 0 && j < n else {
        return
    }
    
    /// 已经访问了
    guard !visited[i][j] else {
        return
    }
    
    /// 搜索目前字母组合是否是单词前缀
    let str = str + "\(board[i][j])"
    guard trie.prefixWith(str) else {
        return
    }
    
    /// 确认当前字母组合是否为单词前缀
    if trie.isWord(str) && !res.contains(str) {
        res.append(str)
    }
    
    /// 继续搜索上、下、左、右四个方向
    visited[i][j] = true
    dfs(board, m, n, i + 1, j, &visited, &res, trie, str)
    dfs(board, m, n, i - 1, j, &visited, &res, trie, str)
    dfs(board, m, n, i, j + 1, &visited, &res, trie, str)
    dfs(board, m, n, i, j - 1, &visited, &res, trie, str)
    visited[i][j] = true
}
