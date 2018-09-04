//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

class Lesson017: NSObject {
    
    /// 问题：给你两个单词word1和word2，请问至少需要几次删除操作使得word1和word2变得一样？每一步你都可以从word1或者word2里删除一个字符。例如如果输入两个单词"sea"和"eat"，我们至少需要两步删除操作，分别删除第一个单词的's'和第二个单词的't'，使得它们变成相同的"ea"。
    static func minDistance(word1: String, word2: String) -> Int {
        let lcs = longestCommonSubsequence2(word1: word1, word2: word2)
        return word1.count - lcs + word2.count - lcs
    }
    
    /// 求两个单词最长公共子串 解法一：空间效率O(n^2) 如果两个字符串的长度分别是m和n，上述代码的时间和空间复杂度都是O(mn)。
    /// 由于这是一个求解最优解的问题（“最长”公共子串），我们可以尝试应用动态规划。应用动态规划的第一步找出状态转移函数。我们用函数f(i,j)表示第一个字符串s1的前i个字符组成的子字符串和第二个字符串s2的前j个字符组成的子字符串的最长公共子串的长度。
    /// 我们分两种情况讨论这个函数。如果s1中的第i个字符和s2中的第j个字符相同，f(i,j)等于f(i-1,j-1)+1。这相当于在s1的前i-1个字符组成的子字符串和s2的前j-1个字符组成的子字符串的最长公共子串的基础上增加了一个公共的字符。
    /// 如果s1中的第i个字符和s2中的第j个字符不同，f(i,j)等于f(i-1,j)和f(i,j-1)的较大值。既然s1中的第i个字符和s2中的第j个字符不同，我们可以忽略s1中的第i个字符，去看看在s1的前i-1个字符组成的子字符串和s2的前j个字符组成的子字符串的最长公共子串的长度，这就是f(i-1,j)的值。同样，我们也可以忽略s2中的第j个字符，去看看在s1的前i个字符组成的子字符串和s2的前j-1个字符组成的子字符串的最长公共子串的长度，这就是f(i,j-1)的值。
    /// 由于状态转移函数有两个变量i和j，我们可以用一个二维矩阵来存储f(i,j)的值。以下就是基于二维矩阵的代码：
    static func longestCommonSubsequence1(word1: String, word2: String) -> Int {
        var dp = Array(repeating: Array(repeating: 0, count: word2.count + 1), count: word1.count + 1)
        for i in 1...word1.count {
            for j in 1...word2.count {
                if Array(word1)[i - 1] == Array(word2)[j - 1] {
                    dp[i][j] = dp[i - 1][j - 1] + 1
                } else {
                    dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
                }
            }
        }
        
        return dp[word1.count][word2.count]
    }
    
    /// 求两个单词最长公共子串  解法二：空间效率O(n) 需要两重循环，因此时间复杂度仍然是O(mn)。由于只需要一个一维数组，因此空间复杂度是O(n)。
    static func longestCommonSubsequence2(word1: String, word2: String) -> Int {
        var dp = Array(repeating: 0, count: word2.count + 1)
        for i in 1...word1.count {
            var prev = 0
            for j in 1...word2.count {
                let cur = Array(word1)[i - 1] == Array(word2)[j - 1]
                    ? dp[j - 1] + 1
                    : max(dp[j], prev)
                
                dp[j - 1] = prev
                prev = cur
            }
            
            dp[word2.count] = prev
        }
        
        return dp[word2.count]
    }
    
    /// 给我们两个字符串s1和s2，请问如何删除字符使得两个字符串相同，并且被删除的字符的ASCII值的和最小？求被删除的字符的ASCII值的和的最小值。这是LeetCode的第712题。这实际上前面问题的变种。我们如果能求出ASCII值最大的公共字串，那么其他的就是被删除的ASCII值的和最小的字符。因此我们我们只需要在前面代码的基础上稍微改改，就能解决这个问题。
    static func minimumDeleteSum(s1: String, s2: String) -> UInt32 {
        var sum1: UInt32 = 0
        for ch in Array(s1) {
            if let value = ch.unicodeScalars.last?.value {
                sum1 += value
            }
        }
        
        var sum2: UInt32 = 0
        for ch in Array(s2) {
            if let value = ch.unicodeScalars.last?.value {
                sum2 += value
            }
        }
        
        let maxCommon = maxCommonSub(s1: s1, s2: s2)
        return sum1 - maxCommon + sum2 - maxCommon
    }
    
    static private func maxCommonSub(s1: String, s2: String) -> UInt32 {
        var dp = Array(repeating: UInt32(0), count: s2.count + 1)
        for i in 1...s1.count {
            var prev: UInt32 = 0
            
            for j in 1...s2.count {
                let cur = Array(s1)[i - 1] == Array(s2)[j - 1]
                    ? dp[j - 1] + Array(s1)[i - 1].unicodeScalars.last!.value
                    : max(dp[j], prev)
                
                dp[j - 1] = prev
                prev = cur
            }
            
            dp[s2.count] = prev
        }
        
        return dp[s2.count]
    }
    
}
