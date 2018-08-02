//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

/// 求斐波拉契数列第100个数字是多少
func Fib() -> Int {
    var (prev, curr) = (0, 1)
    
    for _ in 1..<100 {
        (curr, prev) = (curr + prev, curr)
    }
    
    return curr
}

/// 动态规划的写法
func Fib(_ n: Int) -> Int {
    /// 定义初始状态
    guard n > 0 else {
        return 0
    }
    if n == 1 || n == 2 {
        return 1
    }
    
    /// 调用动态转移方程
    return Fib(n - 1) + Fib(n - 2)
}

func FibTest() {
    let num = Fib(10)
    print("Fib(10) == \(num)")
    /// 如果Fib(100)则发现计算的复杂度太高，有很多重复计算
    
    print("Fib(40) == \(Fib(40))")
}

/// 用一个数组，将计算过的值存下来，通过牺牲内存空间来提高效率。
var nums = Array(repeating: 0, count: 100)

func Fib1(_ n: Int) -> Int {
    /// 定义初始状态
    guard n > 0 else {
        return 0
    }
    if n == 1 || n == 2 {
        return 1
    }
    
    /// 如果已经计算过了，就直接调用，无需重复计算
    if nums[n - 1] != 0 {
        return nums[n - 1]
    }
    
    /// 将计算后的值存入数组
    nums[n - 1] = Fib1(n - 1) + Fib1(n - 2)
    
    return nums[n - 1]
}

/// 求任意两个单词的距离
func wordDistance(_ wordA: String, _ wordB: String) -> Int {
    let aChars = [Character](wordA)
    let bChars = [Character](wordB)
    let aLen = aChars.count
    let bLen = bChars.count
    
    var dp = Array(repeating: Array(repeating: 0, count: bLen + 1), count: aLen + 1)
    
    for i in 0...aLen {
        for j in 0...bLen {
            /// 初始情况
            if i == 0 {
                dp[i][j] = j
            } else if j == 0 {
                dp[i][j] = i
            } else if aChars[i - 1] == bChars[j - 1] {
                /// 特殊情况
                dp[i][j] = dp[i - 1][j - 1]
            } else {
                /// 状态转移方程
                dp[i][j] = min(dp[i - 1][j - 1], dp[i - 1][j], dp[i][j - 1]) + 1
            }
        }
    }
    
    return dp[aLen][bLen]
}
