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

func testLinkedList() {
    let obj = MyLinkedList()
    /*
    // ["MyLinkedList","addAtHead","addAtTail","addAtIndex","get","deleteAtIndex","get"]
    // [[],[1],[3],[1,2],[1],[1],[1]]
    obj.addAtHead(1)
    obj.printList()
    
    obj.addAtTail(3)
    obj.printList()
    
    obj.addAtIndex(1, 2)
    obj.printList()
    
    print(obj.get(1))
    
    obj.deleteAtIndex(1)
    obj.printList()
    
    print(obj.get(1))
    */
    
    /*
    // ["MyLinkedList","addAtHead","deleteAtIndex"]
    // [[],[1],[0]]
    obj.addAtHead(1)
    obj.printList()
    
    obj.deleteAtIndex(0)
    obj.printList()
     */
    
    // ["MyLinkedList","addAtTail","get"]
    // [[],[1],[0]]
    obj.addAtTail(1)
    obj.printList()
    
    print(obj.get(0))
}
