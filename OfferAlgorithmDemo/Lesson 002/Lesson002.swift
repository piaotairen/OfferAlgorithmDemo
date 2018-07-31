//
//  Lesson002.swift
//  OfferAlgorithmDemo
//
//  Created by Cobb on 2018/7/30.
//  Copyright © 2018年 Cobb. All rights reserved.
//
//  -------------------------------------------------------------
//  Lesson002 --> 翻转句子中单词的顺序
//  Reverse a string between two pointers
//  Input: pBegin - the begin pointer in a string
//          pEnd   - the end pointer in a string
//  -------------------------------------------------------------
//

import Cocoa

class Lesson002: NSObject {
    
    /// 翻转整个字符串  I am -> ma I
    ///
    /// - Parameters:
    ///   - chars: 翻转的字符串
    ///   - start: 起始位置
    ///   - end: 结束位置
    static fileprivate func _reverse<T>(_ chars: inout [T], _ start: Int, end: Int) {
        var start = start, end = end
        
        while start < end {
            _swap(&chars, start, end)
            start += 1
            end -= 1
        }
    }
    
    /// 替换字符串中的两个字符
    ///
    /// - Parameters:
    ///   - chars: 替换的字符串
    ///   - p: 待替换字符
    ///   - q: 待替换字符
    static fileprivate func _swap<T>(_ chars: inout [T], _ p: Int, _ q: Int) {
        (chars[p], chars[q]) = (chars[q], chars[p])
    }
    
    
    static func test() {
        
        ///   Reverse a string between two pointers
        ///
        /// - Parameter word: string
        func reverseWords(s: String?) -> String? {
            guard let s = s else {
                return nil
            }
            
            var chars = Array(s), start = 0
            _reverse(&chars, start, end: chars.count - 1)
            
            for i in 0..<chars.count {
                if i == chars.count - 1 || chars[i + 1] == " " {
                    _reverse(&chars, start, end: i)
                    start = i + 2
                }
            }
            
            return String(chars)
        }
        
        let string = "I am a student!"
        let result = reverseWords(s: string)
        print("翻转字符串 \(string) 为 \(result ?? "")")
        
        
        //        void Reverse(char *pBegin, char *pEnd)
        //        {
        //            if(pBegin == NULL || pEnd == NULL)
        //            return;
        //
        //            while(pBegin < pEnd)
        //            {
        //                char temp = *pBegin;
        //                *pBegin = *pEnd;
        //                *pEnd = temp;
        //
        //                pBegin ++, pEnd --;
        //            }
        //        }
        
        
        //        char* ReverseSentence(char *pData)
        //        {
        //            if(pData == NULL)
        //            return NULL;
        //
        //            char *pBegin = pData;
        //            char *pEnd = pData;
        //
        //            while(*pEnd != '\0')
        //            pEnd ++;
        //            pEnd--;
        //
        //            // Reverse the whole sentence
        //            Reverse(pBegin, pEnd);
        //
        //            // Reverse every word in the sentence
        //            pBegin = pEnd = pData;
        //            while(*pBegin != '\0')
        //            {
        //                if(*pBegin == ' ')
        //                {
        //                    pBegin ++;
        //                    pEnd ++;
        //                    continue;
        //                }
        //                    // A word is between with pBegin and pEnd, reverse it
        //                else if(*pEnd == ' ' || *pEnd == '\0')
        //                {
        //                    Reverse(pBegin, --pEnd);
        //                    pBegin = ++pEnd;
        //                }
        //                else
        //                {
        //                    pEnd ++;
        //                }
        //            }
        //
        //            return pData;
        //        }
    }
}
