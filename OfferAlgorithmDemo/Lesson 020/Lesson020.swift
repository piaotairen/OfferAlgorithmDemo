//
//  Lesson008.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/8/1.
//  Copyright © 2018年 Phicomm. All rights reserved.
//

import Foundation

/// 钱币组合
///
/// - Parameters:
///   - coins: 钱币种类
///   - n: 花费钱币的总额
/// - Returns: 返回组合的数组
func coinCounts(coins: [Int], total: Int) -> [Int] {
    let maxCount = total + 1
    var dp = [Int].init(repeating: 0, count: maxCount)
    dp[0] = 1
    var groups = [[[Int]]].init(repeating: [[Int]].init(repeating: [Int].init(repeating: 0, count: coins.count), count: maxCount), count: maxCount)
    groups[0][0] = [0, 0, 0]
    for i in 0..<coins.count {
        if coins[i] <= maxCount {
            for j in coins[i]..<maxCount {
                dp[j] = dp[j] + dp[j - coins[i]]
                groups[j][dp[j]][i] = j
            }
        }
    }
    
    print("钱币总额 == \(total) 的组合方式有dp == \(dp[total])种")
    print("group == \(groups[total])")
    return dp
}

/// 测试
func testcoinCounts() {
    let coins = [1, 5, 10]
    let total = 10
    let counts = coinCounts(coins: coins, total: total)
    print("counts == \(counts)")
}
