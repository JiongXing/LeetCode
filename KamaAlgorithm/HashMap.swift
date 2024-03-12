//
//  HashMap.swift
//  KamaAlgorithm
//
//  Created by jxing on 2024/3/12.
//

import Foundation

/*
 242. 有效的字母异位词
 给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
 注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。
 */
func lc242_有效的字母异位词(s: String, t: String) -> Bool {
    // 哈希表，字典
    // key: 字母，value: 出现次数
    var map = [Character: Int]()
    for ch in s {
        let count = map[ch] ?? 0
        map[ch] = count + 1
    }
    for ch in t {
        let count = map[ch] ?? 0
        if count == 0 {
            return false
        }
        map[ch] = count - 1
    }
    for count in map.values {
        if count != 0 {
            return false
        }
    }
    return true
}
