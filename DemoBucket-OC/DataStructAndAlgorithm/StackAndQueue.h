//
//  StackAndQueue.h
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/20.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define maxSize 100
//顺序栈定义
typedef struct
{
    int data[maxSize];
    int top;
}SqStack;
//链栈的定义
typedef struct LNode
{
    int data;
    struct LNode *next;
}LNode;
//顺序队列的定义
typedef struct
{
    int data[maxSize];
    int front;
    int rear;
}SqQueue;
//链队的定义
typedef struct QNode
{
    int data;
    struct QNode *next;
}Qnode;
typedef struct
{
    Qnode *front;
    Qnode *rear;
}LiQueue;

@interface StackAndQueue : NSObject

@end
/*
 栈的定义：一种只能在一端进行插入和删除操作的线性表。其中允许插入和删除操作的一端乘坐栈顶，另一端称作栈底。栈的插入和删除操作一般称为入栈和出栈。
 栈的特点：先进后出FILO。
 栈的存储结构：顺序栈和链栈。
 站的数学性质：当n个元素以某种顺序进栈，并可在任意时刻出栈，所获得的元素排列的数目N恰好满足函数Catalan()的计算，即 N = Cn2n*1/(n+1)
 
 队列的定义：仅允许在一端（队尾Rear）进行插入在另一端（队头Front）进行删除操作的线性表。插入和删除操作分别称为入队和出队。
 队列的特点：先进先出FIFO。
 队列的存储结构：顺序队和链队。
 */
