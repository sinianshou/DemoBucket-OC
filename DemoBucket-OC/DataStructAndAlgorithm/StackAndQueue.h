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

//初始化顺序栈代码
void initStack(SqStack *st);
//判断栈空代码
int isEmpty(SqStack st);
//进栈代码
int push(SqStack *st, int x);
//出栈代码
int pop(SqStack *st,int *x);
//链栈的初始化代码
void initStack_L(LNode **lst);
//判断栈空代码
int isEmpty_L(LNode *lst);
//进栈代码
void push_L(LNode *lst, int x);
//出栈代码
int pop_L(LNode *lst, int *x);
//初始化队列
void initQueue(SqQueue *qu);
//判断队空
int isQueueEmpty(SqQueue qu);
//进队算法
int enQueue(SqQueue *qu, int x);
//出队算法
int deQueue(SqQueue *qu, int *x);
//初始化链队
void initQueue_L(LiQueue **lqu);
//判断队空
int isQueueempty_L(LiQueue *lqu);
//入队算法
void enQueue_L(LiQueue *lqu, int x);
//出队算法
int deQueue_L(LiQueue *lqu, int *x);

@end
/*
 栈的定义：一种只能在一端进行插入和删除操作的线性表。其中允许插入和删除操作的一端乘坐栈顶，另一端称作栈底。栈的插入和删除操作一般称为入栈和出栈。
 栈的特点：先进后出FILO。
 栈的存储结构：顺序栈和链栈。
 栈的数学性质：当n个元素以某种顺序进栈，并可在任意时刻出栈，所获得的元素排列的数目N恰好满足函数Catalan()的计算，即 N = Cn2n*1/(n+1)
 顺序栈的几个状态：栈空状态、栈满状态、非法状态（上溢和下溢）。
 顺序栈的应用：判断表达式中括号是否正确配对、求后缀式的数值
 
 队列的定义：仅允许在一端（队尾Rear）进行插入在另一端（队头Front）进行删除操作的线性表。插入和删除操作分别称为入队和出队。
 队列的特点：先进先出FIFO。
 队列的存储结构：顺序队和链队。
 */
