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
 模糊范围知识点
 共享栈：为了增加内存空间的利用率和减少溢出的可能性，当两个栈共享一片连续的内存空间时，应将两个栈的栈底分别设在这片内存空间的两端，这样当两个栈的栈顶在栈空间的某一位置相遇时，才产生上溢。
 双端队列：一种插入和删除操作在两端均可进行的线性表，可以看成栈底连在一起的两个栈。
 ？？？问题，有待再次学习？？？
 双端队列依次入队1234，
 1. 能由输入受限的双端队列得到，但不能由输出受限的双端队列得到的输出序列
 2. 能由输出受限得双端队列得到，但不能由输入受限的双端队列得到的输出序列
 3. 既不能由输入受限的双端队列得到，也不能由输出受限的双端队列得到的输出序列
 抽象数据类型（Abstract  Data Type，ADT）：
 1. 关于ADT概念的理解：数据对象集，数据关系集和操作集
 2. 关于ADT的应用：多为设计题，简单的可以语言描述，如栈和队列ADT，复杂的最好用类结构体方法描述。
 例题：设计一个图书馆ADT
 数据集描述：图书馆需要有自己的名字以及一些放书的书架，书架一般没有名字而有编号，以及若干书，书一般有名字、作者、编号等信息。
 操作集描述：依据书架编号查找书架，依据书编号查找书，依据书名查找书，依据作者查找书，添加书，删除书，借书，还书等操作。
 ADT 书
 {
    数据对象集：
        书名；
        书号；
        作者；
 }；
 ADT 书架
 {
    数据对象集：
        书架号：
        书 = {书0, 书1, ..., 书n}；
    数据关系集：
        书在书架上的排列方式 = {<书0， 书1>, <书1， 书2>, ..., <书n-1， 书n>}；
 }；
 ADT 图书馆
 {
    数据对象集：
        图书馆名；
        书架 = {书架0，书架1， ..., 书架n}；
    数据关系集：
        书架在图书馆中的排列方式 = {<书架0， 书架1>, <书架1， 书架2>, ..., <书架n-1， 书架n>}；
    操作集：
        依据书架号查找书架；
        依据书号查找书；
        依据书名查找书；
        依据作者查找书；
        添加书；
        删除书；
        借书；
        还书；
 }
 设计ADT的题目需要注意以下几点：
 1. 注意ADT的结构格式，类似于C语言的结构体的写法。
 2. ADT大括号内用数据对象集、数据关系集和操作集分开。
 3. 一般必有数据对象集。
 4. 如果数据对象之间有很强的关联性，则应写出合适的数据关系集。如果遇到树形结构或图结构的数据关系，则用类似的边集表示方法写出。最可能出现的四种关系：无关系、顺序关系、树关系、图关系。
 5. 若有操作集，则写出。
 6. 不同的数据对象类型，自上而下一次列出。
 7. 相同的数据对象，用集合表示法写出。
 不同的操作自上而下写出。

 */
