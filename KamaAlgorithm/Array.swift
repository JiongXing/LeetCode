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
        let middleIndex = leftIndex + (rightIndex - leftIndex) / 2
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
        let middleIndex = leftIndex + (rightIndex - leftIndex) / 2
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
        let middleIndex = leftIndex + (rightIndex - leftIndex) / 2
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
    // 二分查找
    var left = 0
    var right = x
    while left <= right {
        let middle = left + (right - left) / 2
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

/**
 367. 有效的完全平方数
 给你一个正整数 num 。如果 num 是一个完全平方数，则返回 true ，否则返回 false 。
 完全平方数 是一个可以写成某个整数的平方的整数。换句话说，它可以写成某个整数和自身的乘积。
 不能使用任何内置的库函数，如  sqrt
 */
func lc367_有效的完全平方数(num: Int) -> Bool {
    // 二分查找
    var left = 0
    var right = num
    while left <= right {
        let middle = left + (right - left) / 2
        let temp = middle * middle
        if num < temp {
            right = middle - 1
        } else if num > temp {
            left = middle + 1
        } else {
            return true
        }
    }
    return false
}

/**
 27. 移除元素
 给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
 不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并原地修改输入数组。
 元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。
 */
func lc27_移除元素(nums: inout [Int], val: Int) -> Int {
    // 原地删除，用快慢指针。慢指针指向要更新值的位置，快指针寻找新值
    guard nums.count > 0 else {
        return 0
    }
    var slow = 0
    var fast = 0
    while fast < nums.count {
        if nums[fast] != val {
            nums[slow] = nums[fast]
            slow += 1
        }
        fast += 1
    }
    return slow
}


/**
 26. 删除有序数组中的重复项
 给你一个 非严格递增排列 的数组 nums ，请你 原地 删除重复出现的元素，使每个元素 只出现一次 ，返回删除后数组的新长度。元素的 相对顺序 应该保持 一致 。然后返回 nums 中唯一元素的个数。
 */
func lc26_删除有序数组中的重复项(nums: inout [Int]) -> Int {
    // 因为有序，重复项都挨在一起
    // 慢指针指向每个数字第一次出现的位置，fast指针寻找下个数字的位置
    // 找到新数时，把fast指向值赋值给slow+1位置
    guard nums.count > 0 else {
        return 0
    }
    var slow = 0
    var fast = 0
    while fast < nums.count {
        if nums[fast] != nums[slow] {
            nums[slow + 1] = nums[fast]
            slow += 1
        }
        fast += 1
    }
    return slow + 1
}

/**
 283. 移动零
 给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
 请注意 ，必须在不复制数组的情况下原地对数组进行操作。
 https://leetcode.cn/problems/move-zeroes/description/
 */
func lc283_移动零(nums: inout [Int]) {
    // 快慢指针，slow指向要更新的位置，fast寻找非0数据，交互
    guard nums.count > 0 else {
        return
    }
    var slow = 0
    var fast = 0
    while fast < nums.count {
        // 非0就赋值
        if nums[fast] != 0 {
            // 把0交互到后面去
            (nums[slow], nums[fast]) = (nums[fast], nums[slow])
            slow += 1
        }
        fast += 1
    }
}

/**
 844. 比较含退格的字符串
 给定 s 和 t 两个字符串，当它们分别被输入到空白的文本编辑器后，如果两者相等，返回 true 。# 代表退格字符。
 注意：如果对空文本输入退格字符，文本继续为空。
 https://leetcode.cn/problems/backspace-string-compare/description/
 */
func lc844_比较含退格的字符串(s: String, t: String) -> Bool {
    // 求出退格后字符串
    func getBackspaceString(s: String) -> [Character] {
        var sChars: [Character] = []
        for ch in s {
            if ch != "#" {
                sChars.append(ch)
            } else {
                if sChars.count > 0 {
                    sChars.removeLast()
                }
            }
        }
        return sChars
    }
    
    let sChars = getBackspaceString(s: s)
    let tChars = getBackspaceString(s: t)
    var sIndex = sChars.count - 1
    var tIndex = tChars.count - 1
    while sIndex >= 0 && tIndex >= 0 {
        if sChars[sIndex] == tChars[tIndex] {
            sIndex -= 1
            tIndex -= 1
            continue
        }
        return false
    }
    // 任意一个遍历完
    return (sIndex == tIndex)
}

/**
 977. 有序数组的平方
 给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。
 */
func lc977_有序数组的平方(nums: [Int]) -> [Int] {
    // 从后往前填数，平方后最大值一定在nums的两端
    guard nums.count > 0 else {
        return []
    }
    var left = 0
    var right = nums.count - 1
    var ans = [Int](repeating: 0, count: nums.count)
    var insertIndex = ans.count - 1
    while left <= right {
        let leftValue = nums[left] * nums[left]
        let rightValue = nums[right] * nums[right]
        if leftValue > rightValue {
            ans[insertIndex] = leftValue
            left += 1
        } else {
            ans[insertIndex] = rightValue
            right -= 1
        }
        insertIndex -= 1
    }
    return ans
}

/**
 209.长度最小的子数组
 给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的 连续 子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。
 https://leetcode.cn/problems/minimum-size-subarray-sum/description/
 */
func lc209_长度最小的子数组(target: Int, nums: [Int]) -> Int {
    guard nums.count > 0 else {
        return 0
    }
    // 滑动窗口
    var left = 0
    var right = 0
    // 窗口的值
    var sum = 0
    var minLength = Int.max
    // 扩大窗口
    while right < nums.count {
        sum += nums[right]
        while sum >= target {
            // 窗口符合条件
            if right - left + 1 < minLength {
                minLength = right - left + 1
            }
            // 缩小左边界，收紧窗口
            sum -= nums[left]
            left += 1
        }
        right += 1
    }
    return minLength != Int.max ? minLength : 0
}

/**
 904. 水果成篮
 你正在探访一家农场，农场从左到右种植了一排果树。这些树用一个整数数组 fruits 表示，其中 fruits[i] 是第 i 棵树上的水果 种类 。
 你想要尽可能多地收集水果。然而，农场的主人设定了一些严格的规矩，你必须按照要求采摘水果：
 你只有 两个 篮子，并且每个篮子只能装 单一类型 的水果。每个篮子能够装的水果总量没有限制。
 你可以选择任意一棵树开始采摘，你必须从 每棵 树（包括开始采摘的树）上 恰好摘一个水果 。采摘的水果应当符合篮子中的水果类型。每采摘一次，你将会向右移动到下一棵树，并继续采摘。
 一旦你走到某棵树前，但水果不符合篮子的水果类型，那么就必须停止采摘。
 给你一个整数数组 fruits ，返回你可以收集的水果的 最大 数目。
 https://leetcode.cn/problems/fruit-into-baskets/description/
 */
func lc904_水果成篮(fruits: [Int]) -> Int {
    // 题目翻译：找出至多包含2种元素的最长子串，返回子串长度
    // 滑动窗口
    var left = 0
    var right = 0
    // 哈希表记录水果种类和个数
    var buket = [Int: Int]()
    var maxLength = 0
    while right < fruits.count {
        let current = fruits[right]
        buket[current] = (buket[current] ?? 0) + 1
        // 缩小窗口，直到只包含2种水果
        while buket.count > 2 {
            let leftKey = fruits[left]
            if let leftNum = buket[leftKey] {
                buket[leftKey] = leftNum - 1
                if buket[leftKey] == 0 {
                    buket.removeValue(forKey: leftKey)
                }
            }
            left += 1
        }
        maxLength = max(maxLength, right - left + 1)
        right += 1
    }
    return maxLength
}

/**
 59.螺旋矩阵II
 给定一个正整数 n，生成一个包含 1 到 n^2 所有元素，且元素按顺时针顺序螺旋排列的正方形矩阵。
 示例:
 输入: 3 输出: [ [ 1, 2, 3 ], [ 8, 9, 4 ], [ 7, 6, 5 ] ]
 https://leetcode.cn/problems/spiral-matrix-ii/description/
 */
func lc59_螺旋矩阵II(n: Int) -> [[Int]] {
    // 模拟法
    var topBorder = 0
    var rightBorder = n - 1
    var bottomBorder = n - 1
    var leftBorder = 0
    var matrix = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    var value = 1
    while true {
        // 上
        for col in leftBorder...rightBorder {
            matrix[topBorder][col] = value
            value += 1
        }
        topBorder += 1
        if topBorder > bottomBorder {
            break
        }
        
        // 右
        for row in topBorder...bottomBorder {
            matrix[row][rightBorder] = value
            value += 1
        }
        rightBorder -= 1
        if rightBorder < leftBorder {
            break
        }
        
        // 下
        for col in stride(from: rightBorder, to: leftBorder - 1, by: -1) {
            matrix[bottomBorder][col] = value
            value += 1
        }
        bottomBorder -= 1
        if bottomBorder < topBorder {
            break
        }
        
        // 左
        for row in stride(from: bottomBorder, to: topBorder - 1, by: -1) {
            matrix[row][leftBorder] = value
            value += 1
        }
        leftBorder += 1
        if leftBorder > rightBorder {
            break
        }
    }
    return matrix
}

/**
 54. 螺旋矩阵
 给你一个 m 行 n 列的矩阵 matrix ，请按照 顺时针螺旋顺序 ，返回矩阵中的所有元素。
 */
func lc54_螺旋矩阵(matrix: [[Int]]) -> [Int] {
    let m = matrix.count
    guard m > 0 else {
        return []
    }
    let n = matrix[0].count
    guard n > 0 else {
        return [n]
    }
    var topBorder = 0
    var bottomBorder = m - 1
    var leftBorder = 0
    var rightBorder = n - 1
    var ans = [Int]()
    while true {
        // top
        for col in leftBorder...rightBorder {
            ans.append(matrix[topBorder][col])
        }
        topBorder += 1
        if topBorder > bottomBorder {
            break
        }
        
        // right
        for row in topBorder...bottomBorder {
            ans.append(matrix[row][rightBorder])
        }
        rightBorder -= 1
        if rightBorder < leftBorder {
            break
        }
        
        // bottom
        for col in stride(from: rightBorder, to: leftBorder - 1, by: -1) {
            ans.append(matrix[bottomBorder][col])
        }
        bottomBorder -= 1
        if bottomBorder < topBorder {
            break
        }
        
        // left
        for row in stride(from: bottomBorder, to: topBorder - 1, by: -1) {
            ans.append(matrix[row][leftBorder])
        }
        leftBorder += 1
        if leftBorder > rightBorder {
            break
        }
    }
    return ans
}

func testArray() {
    let arr = [3,3,3,1,2,1,1,2,3,3,4]
    print("输入：\(arr)")
    let ans = lc904_水果成篮(fruits: arr)
    print("输出：\(ans)")
    
    print("3749.31 / 8314.02 = \(3749.31 / 8314.02)")
}
