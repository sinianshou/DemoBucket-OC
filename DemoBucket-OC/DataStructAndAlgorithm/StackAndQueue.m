//
//  StackAndQueue.m
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/20.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import "StackAndQueue.h"



@implementation StackAndQueue

//初始化顺序栈代码  //int stack[maxSize]; int top=-1;
void initStack(SqStack *st)
{
    st->top = -1;
}
//判断栈空代码
int isEmpty(SqStack st)
{
    if (st.top == -1) {
        return 1;
    }else
    {
        return 0;
    }
}
//进栈代码  //stack[++top] = x;
int push(SqStack *st, int x)
{
    if (st->top == maxSize-1) {
        return 0;
    }
    ++(st->top);
    st->data[st->top] = x;
    return 1;
}
//出栈代码  //x = stack[top--];
int pop(SqStack *st,int *x)
{
    if (st->top == -1) {
        return 0;
    }
    x = &st->data[st->top];
    --(st->top);
    return 1;
}

//链栈的初始化代码
void initStack_L(LNode **lst)
{
    lst = (LNode**)malloc(sizeof(LNode));
    (**lst).next = nil;
}
//判断栈空代码
int isEmpty_L(LNode *lst)
{
    if (lst->next == nil) {
        return 1;
    }else
    {
        return 0;
    }
}
//进栈代码
void push_L(LNode *lst, int x)
{
    LNode *p;
    p = (LNode*)malloc(sizeof(LNode));
    p->next = nil;
    p->next = lst->next;
    p->data = x;
    lst->next = p;
}
//出栈代码
int pop_L(LNode *lst, int *x)
{
    LNode *p;
    if (lst->next == nil) {
        return 0;
    }
    p = lst->next;
    x = &p->data;
    lst->next = p->next;
    free(p);
    return 1;
}
//初始化队列
void initQueue(SqQueue *qu)
{
    qu->front = qu->rear = 0;
}
//判断队空
int isQueueEmpty(SqQueue qu)
{
    if (qu.front == qu.rear) {
        return 1;
    }else
    {
        return 0;
    }
}
//进队算法
int enQueue(SqQueue *qu, int x)
{
    if ((qu->rear+1)%maxSize == qu->front) {
        return 0;
    }
    qu->rear = (qu->rear+1)%maxSize;
    qu->data[qu->rear] = x;
    return 1;
}
//出对算法
int deQueue(SqQueue *qu, int *x)
{
    if (qu->front == qu->rear) {
        return 0;
    }
    qu->front = (qu->front+1)%maxSize;
    *x=qu->data[qu->front];
    return 1;
}
//初始化链队
void initQueue_L(LiQueue **lqu)
{
    lqu = (LiQueue**)malloc(sizeof(LiQueue));
    (**lqu).front=(**lqu).rear=nil;
}
//判断队空
int isQueueempty_L(LiQueue *lqu)
{
    if (lqu->rear == nil || lqu->front == nil) {
        return 1;
    }else
    {
        return 0;
    }
}
//入队算法
void enQueue_L(LiQueue *lqu, int x)
{
    Qnode *p;
    p = (Qnode*)malloc(sizeof(Qnode));
    p->data = x;
    p->next = nil;
    if (lqu->rear == nil || lqu->front == nil) {
        lqu->rear = lqu->front = p;
    }else
    {
        lqu->rear->next = p;
        lqu->rear = p;
    }
    
}
//出队算法
int deQueue_L(LiQueue *lqu, int *x)
{
    if (lqu->rear == nil || lqu->front == nil) {
        return 0;
    }else
    {
        Qnode *p = lqu->front;
        if (lqu->rear == lqu->front) {
            lqu->rear = lqu->front = nil;
        }else
        {
            lqu->front = lqu->front->next;
        }
        *x = p->data;
        free(p);
        return 1;
    }
}

@end

