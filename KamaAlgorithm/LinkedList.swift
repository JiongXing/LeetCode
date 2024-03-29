//
//  Link.swift
//  KamaAlgorithm
//
//  Created by jxing on 2024/2/27.
//

import Foundation

/*
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */

/*
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */

class ListNode {
    var val: Int
    var next: ListNode?
    var prev: ListNode?
    
    init() {
        self.val = 0
        self.next = nil
    }
    
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}

/**
 203. 移除链表元素
 给你一个链表的头节点 head 和一个整数 val ，请你删除链表中所有满足 Node.val == val 的节点，并返回 新的头节点 。
 */
func lc203_移除链表元素(head: ListNode, val: Int) -> ListNode? {
    let dummyHead = ListNode()
    dummyHead.next = head
    var cur: ListNode? = dummyHead
    while let next = cur?.next {
        if next.val == val {
            // 把next删掉
            cur?.next = next.next
            // 此时的cur.next指向还没遍历的新值，进入下次循环
        } else {
            cur = cur?.next
        }
    }
    return dummyHead.next
}

/**
 707. 设计链表
 你可以选择使用单链表或者双链表，设计并实现自己的链表。
 单链表中的节点应该具备两个属性：val 和 next 。val 是当前节点的值，next 是指向下一个节点的指针/引用。
 如果是双向链表，则还需要属性 prev 以指示链表中的上一个节点。假设链表中的所有节点下标从 0 开始。

 实现 MyLinkedList 类：
 MyLinkedList() 初始化 MyLinkedList 对象。
 int get(int index) 获取链表中下标为 index 的节点的值。如果下标无效，则返回 -1 。
 void addAtHead(int val) 将一个值为 val 的节点插入到链表中第一个元素之前。在插入完成后，新节点会成为链表的第一个节点。
 void addAtTail(int val) 将一个值为 val 的节点追加到链表中作为链表的最后一个元素。
 void addAtIndex(int index, int val) 将一个值为 val 的节点插入到链表中下标为 index 的节点之前。如果 index 等于链表的长度，那么该节点会被追加到链表的末尾。如果 index 比长度更大，该节点将 不会插入 到链表中。
 void deleteAtIndex(int index) 如果下标有效，则删除链表中下标为 index 的节点。
 */
class MyLinkedList {
    
    private var dummyHead = ListNode()

    init() {

    }
    
    func get(_ index: Int) -> Int {
        guard index >= 0 else {
            return -1
        }
        var cur: ListNode? = dummyHead
        for _ in 0...index {
            cur = cur?.next
            guard cur != nil else {
                break
            }
        }
        return cur?.val ?? -1
    }
    
    func addAtHead(_ val: Int) {
        let node = ListNode(val, dummyHead.next)
        dummyHead.next = node
    }
    
    func addAtTail(_ val: Int) {
        // cur指向最后一个有值节点
        var cur = dummyHead
        while let next = cur.next {
            cur = next
        }
        cur.next = ListNode(val)
    }
    
    func addAtIndex(_ index: Int, _ val: Int) {
        // 让cur指向待插位置的前一个节点
        var cur: ListNode? = dummyHead
        if index >= 1 {
            for _ in 1...index {
                cur = cur?.next
            }
        }
        
        let node = ListNode(val, cur?.next)
        cur?.next = node
    }
    
    func deleteAtIndex(_ index: Int) {
        // 指向待删位置前一个节点
        var cur: ListNode? = dummyHead
        if index >= 1 {
            for _ in 1...index {
                cur = cur?.next
            }
        }
        
        cur?.next = cur?.next?.next
    }
    
    func printList() {
        var arr = [Int]()
        var cur: ListNode? = dummyHead.next
        while cur != nil {
            if let val = cur?.val {
                arr.append(val)
            }
            cur = cur?.next
        }
        print(arr)
    }
}

/**
 206.反转链表
 给你单链表的头节点 head ，请你反转链表，并返回反转后的链表。
 示例: 输入: 1->2->3->4->5->NULL 输出: 5->4->3->2->1->NULL
 https://leetcode.cn/problems/reverse-linked-list/description/
 */
func lc206_反转链表(head: ListNode?) -> ListNode? {
    // 原地改变next指向
    // 双指针，cur.next 指向 pre，同时移动两指针
    var pre: ListNode? = nil
    var cur = head
    while cur != nil {
        var next = cur?.next
        cur?.next = pre
        pre = cur
        cur = next
    }
    return pre
}

/**
 24. 两两交换链表中的节点
 给你一个链表，两两交换其中相邻的节点，并返回交换后链表的头节点。你必须在不修改节点内部的值的情况下完成本题（即，只能进行节点交换）。
 输入：head = [1,2,3,4]
 输出：[2,1,4,3]
 */
func lc24_两两交换链表中的节点(head: ListNode?) -> ListNode? {
    // 要画图理解
    let dummyHead = ListNode()
    dummyHead.next = head
    var prev: ListNode? = dummyHead
    var cur1 = head
    var cur2 = head?.next
    while cur1 != nil && cur2 != nil {
        let next = cur2?.next
        cur2?.next = cur1
        cur1?.next = next
        prev?.next = cur2
        
        prev = cur1
        cur1 = next
        cur2 = next?.next
    }
    return dummyHead.next
}

/**
 19. 删除链表的倒数第 N 个结点
 给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。
 输入：head = [1,2,3,4,5], n = 2
 输出：[1,2,3,5]
 */
func lc19_删除链表的倒数第N个结点(head: ListNode?, n: Int) -> ListNode? {
    guard n > 0 else {
        return head
    }
    let dummyHead = ListNode()
    dummyHead.next = head
    // 快慢指针，fast先slow遍历n步
    // fast遍历到末尾节点时，slow指向倒数第N个节点的前一个节点
    var fast: ListNode? = dummyHead
    var slow: ListNode? = dummyHead
    var count = n
    while count > 0 {
        fast = fast?.next
        count -= 1
    }
    if fast == nil {
        return head
    }
    while fast?.next != nil {
        fast = fast?.next
        slow = slow?.next
    }
    slow?.next = slow?.next?.next
    return dummyHead.next
}

/**
 160. 相交链表
 给你两个单链表的头节点 headA 和 headB ，请你找出并返回两个单链表相交的起始节点。如果两个链表不存在相交节点，返回 null 。
 https://leetcode.cn/problems/intersection-of-two-linked-lists/description/
 */
func lc160_相交链表(headA: ListNode?, headB: ListNode?) -> ListNode? {
    // 末尾对齐两个链表，让两指针指向较短链表表头相对位置，同步遍历
    // 求链表长度差，然后确认长链表先移动的步数
    func length(of list: ListNode?) -> Int {
        var length = 0
        var cur = list
        while cur != nil {
            cur = cur?.next
            length += 1
        }
        return length
    }
    let lenA = length(of: headA)
    let lenB = length(of: headB)
    var longList = headA
    var shortList = headB
    if lenA < lenB {
        longList = headB
        shortList = headA
    }

    var longCur = longList
    var shortCur = shortList
    for _ in 0..<(abs(lenA - lenB)) {
        longCur = longCur?.next
    }

    // 同步移动
    while longCur != nil && shortCur != nil {
        // leetcode判题要求地址相等
        if longCur! === shortCur! {
            return longCur
        }
        longCur = longCur?.next
        shortCur = shortCur?.next
    }
    return nil
}

/*
 141. 环形链表
 给你一个链表的头节点 head ，判断链表中是否有环。
 https://leetcode.cn/problems/linked-list-cycle/description/
 */
func lc141_环形链表(head: ListNode?) -> Bool {
    // 快慢指针，指针相遇表示有环，指针走到nil表示没环
    // 快指针每次2步
    var fast = head
    var slow = head
    while fast != nil && slow != nil {
        fast = fast?.next?.next
        slow = slow?.next
        if fast === slow && fast != nil {
            return true
        }
    }
    return false
}

/*
 142. 环形链表 II
 给定一个链表的头节点  head ，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。
 https://leetcode.cn/problems/linked-list-cycle-ii/
 */
func lc142_环形链表_II(head: ListNode?) -> ListNode? {
    // 假如有环，那么相遇时，起2个指针，分别在相遇点和起点出发，指针相遇的节点就是入环节点
    var fast = head
    var slow = head
    var meet: ListNode?
    while fast != nil && slow != nil {
        fast = fast?.next?.next
        slow = slow?.next
        if fast === slow && fast != nil {
            meet = fast
            break
        }
    }
    print("meet: \(String(describing: meet?.val)))")
    // 如果没相遇
    if meet == nil {
        return nil
    }
    // 相遇，有环
    var p1 = head
    var p2 = meet
    while p1 != nil && p2 != nil {
        if p1 === p2 {
            return p1
        }
        p1 = p1?.next
        p2 = p2?.next
    }
    print("异常！")
    return nil
}

func testLinkedList() {
    let list1 = createList(array: [4,1,8,4,5])
    let list2 = createList(array: [5,0,1,8,4,5])
    let result = lc160_相交链表(headA: list1, headB: list2)
    print("val: \(result?.val ?? 0)")
}

func createList(array: [Int]) -> ListNode? {
    var head: ListNode?
    var pre: ListNode?
    array.forEach { val in
        let node = ListNode()
        node.val = val
        pre?.next = node
        pre = node
        if head == nil {
            head = node
        }
    }
    return head
}
