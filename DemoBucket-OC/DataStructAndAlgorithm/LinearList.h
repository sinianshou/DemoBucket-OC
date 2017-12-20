//
//  LinearList.h
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/20.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

//顺序表的结构体定义
#define maxSize 100
typedef struct
{
    int data[maxSize];
    int length;
}Sqlist;
//顺序表可简写成
int A[maxSize];
int n;
//单链表节点定义
typedef struct LNode
{
    int data;
    struct LNode *next;
}LNode;
//双链表节点定义
typedef struct DLNode
{
    int data;
    struct DLNode *prior;
    struct DLNode *next;
}DLNode;

@interface LinearList : NSObject

int findElem(Sqlist L, int e);
int insertElement(Sqlist L, int p, int e);
void createlistR(LNode *C, int a[], int n);
void createDlistR(DLNode *C, int a[], int n);
void createlistF(LNode *C, int a[], int n);
void createDlistF(DLNode *C, int a[], int n);

@end
/*
 线性表定义：具有相同特性数据元素的有限序列。所含元素的个数 n(n>=0) 叫做线性表的长度。
 线性表的逻辑特性：线性表只有一个表头元素和一个表尾元素，表头元素没有前驱，表尾元素没有后继，其余元素只有一个直接前驱和一个直接后继。
 线性表的存储结构：顺序存储结构（顺序表）和链式存储结构（链表）。
 1. 顺序表：线性表中的所有元素按照逻辑顺序依次存储到从指定的储存位置开始的一块连续的存储空间中。
 2. 链表：链表存储中不仅包含元素信息，还包含元素之间的逻辑关系的信息。
 3. 两种存储结构的比较：
    a. 基于空间的比较
        i. 存储分配的方式：
        顺序表的存储空间是一次性分配的，链表的储存空间是多次分配的。
        ii. 存储密度（存储密度=结点值域所占存储量/结点结构所占存储总量）：
        顺序表的存储密度 = 1，链表的存储密度 < 1（因为结点中有指针域）。
    b. 基于时间的比较
        i. 存取方式：
        顺序表可以随机存取，也可以顺序存取，链表只能顺序存取。
        ii. 插入、删除时移动元素的个数：
        顺序表平均需要移动将近一半的元素，链表不需要移动元素，只需要修改指针。
 */
