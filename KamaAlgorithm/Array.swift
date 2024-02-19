//
//  Array.swift
//  KamaAlgorithm
//
//  Created by jxing on 2024/2/18.
//

import Foundation

/**
 704. 二分查找
 给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。
 */
func lc704_二分查找(nums: [Int], target: Int) -> Int {
    guard nums.count > 0 else {
        return -1
    }
    // 左右两个游标往中间折半移动，每次缩小一半搜索范围
    var leftIndex = 0
    var rightIndex = nums.count - 1
    
    // 处理边界问题，rightIndex可被搜索，是闭区间
    while leftIndex <= rightIndex {
        var middleIndex = leftIndex + (rightIndex - leftIndex) / 2
        if target == nums[middleIndex] {
            return middleIndex
        }
        if target < nums[middleIndex] {
            // middleIndex位置已经比较过，不是目标，所以-1
            rightIndex = middleIndex - 1
        } else {
            leftIndex = middleIndex + 1
        }
    }
    return -1
}

/**
 35.搜索插入位置
 给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
 你可以假设数组中无重复元素。
 */
func lc35_搜索插入位置(nums: [Int], target: Int) -> Int {
    guard nums.count > 0 else {
        return -1
    }
    // 左右两个游标往中间折半移动，每次缩小一半搜索范围
    var leftIndex = 0
    var rightIndex = nums.count - 1
    
    // 处理边界问题，rightIndex可被搜索，是闭区间
    while leftIndex <= rightIndex {
        var middleIndex = leftIndex + (rightIndex - leftIndex) / 2
        if target == nums[middleIndex] {
            return middleIndex
        }
        if target < nums[middleIndex] {
            // middleIndex位置已经比较过，不是目标，所以-1
            rightIndex = middleIndex - 1
        } else {
            leftIndex = middleIndex + 1
        }
    }
    // 搜索不到，最后一次循环开始时，left=right=middle
    // 如果target小于搜索区间，left=right=middle=0，return left
    // 如果target大于搜索区间，left=right=middle= nums.count - 1, return left
    // 如果target在两数之间，target<nums[middle]，return left; target>nums[middle], left+1, return left
    return leftIndex
}

/**
 34. 在排序数组中查找元素的第一个和最后一个位置
 给定一个按照升序排列的整数数组 nums，和一个目标值 target。找出给定目标值在数组中的开始位置和结束位置。
 如果数组中不存在目标值 target，返回 [-1, -1]。
 进阶：你可以设计并实现时间复杂度为 $O(\log n)$ 的算法解决此问题吗？
 */
func lc34_在排序数组中查找元素的第一个和最后一个位置(nums: [Int], target: Int) -> [Int] {
    guard nums.count > 0 else {
        return [-1, -1]
    }
    // 1.二分查找，找目标值
    // 2.在目标index附近找边界
    var leftIndex = 0
    var rightIndex = nums.count - 1
    var targetIndex = -1
    while leftIndex <= rightIndex {
        var middleIndex = leftIndex + (rightIndex - leftIndex) / 2
        if target < nums[middleIndex] {
            rightIndex = middleIndex - 1
        } else if target > nums[middleIndex] {
            leftIndex = middleIndex + 1
        } else {
            targetIndex = middleIndex
            break
        }
    }
    // 如果找不到
    if targetIndex == -1 {
        return [-1, -1]
    }
    
    // 找到了，左右寻找边界
    var leftBorder = targetIndex - 1
    while leftBorder >= 0 {
        if target == nums[leftBorder] {
            leftBorder -= 1
        } else {
            break
        }
    }
    
    var rightBorder = targetIndex + 1
    while rightBorder <= nums.count - 1 {
        if target == nums[rightBorder] {
            rightBorder += 1
        } else {
            break
        }
    }
    
    return [leftBorder + 1, rightBorder - 1]
}

/**
 69. x 的平方根
 给你一个非负整数 x ，计算并返回 x 的 算术平方根 。
 由于返回类型是整数，结果只保留 整数部分 ，小数部分将被 舍去 。
 注意：不允许使用任何内置指数函数和算符，例如 pow(x, 0.5) 或者 x ** 0.5 。
 */
func lc69_x的平方根(x: Int) -> Int {
    var left = 0
    var right = x
    while left <= right {
        var middle = left + (right - left) / 2
        let temp = middle * middle
        if x < temp {
            right = middle - 1
        } else if x > temp {
            left = middle + 1
        } else {
            return middle
        }
    }
    // 如果找不到整数结果，最后会执行left=middle+1，而right不变，right就是向下取整的结果
    return right
}
