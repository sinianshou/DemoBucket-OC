//
//  LinearList.m
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/20.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import "LinearList.h"

@implementation LinearList
//饮用性用&失败，原因不明
//顺序表按元素值查找算法
int findElem(Sqlist L, int e)
{
    int i;
    for (i=0; i<L.length; ++i) {
        if (e==L.data[i]) {
            return i;//返回找到数据的index
        }
    }
    return -1;  //没找到，返回-1作为失败标记
}
//顺序表插入算法
int insertElement(Sqlist L, int p, int e)   //L本身需要发生改变，所以用饮用性
{
    int i;
    //p的插入位置不在范围里或者数组已满，则返回-1标记插入失败
    if (p<0||p>L.length||L.length==maxSize) {
        return -1;
    }
    //将p之后的元素依次后移
    for (i=L.length-1; i>=p; --i) {
        L.data[i+1] = L.data[i];
    }
    L.data[p] = e;
    ++(L.length);   //增长顺序表长度
    return 1;  //返回1标记插入成功
}
//单链表尾插法
void createlistR(LNode *C, int a[], int n)
{
    LNode *s, *r;
    int i;
    C = (LNode *)malloc(sizeof(LNode));
    C->next=NULL;
    r=C;
    for (i=0; i<n; ++i) {
        s = (LNode*)malloc(sizeof(LNode));
        s->data=a[i];
        r->next = s;
        r = r->next;
    }
    r->next = NULL;
}
//双链表尾插法
void createDlistR(DLNode *C, int a[], int n)
{
    DLNode *s, *r;
    int i;
    C = (DLNode *)malloc(sizeof(DLNode));
    C->next=NULL;
    C->prior = NULL;
    r=C;
    for (i=0; i<n; ++i) {
        s = (DLNode*)malloc(sizeof(DLNode));
        s->data=a[i];
        r->next = s;
        s->prior = r;
        r = r->next;
    }
    r->next = NULL;
}
//单链表头插法
void createlistF(LNode *C, int a[], int n)
{
    LNode *s;
    int i;
    C = (LNode*)malloc(sizeof(LNode));
    C->next = NULL;
    for (i=0; i<n; ++i) {
        s = (LNode*)malloc(sizeof(LNode));
        s->data = a[i];
        s->next = C->next;
        C->next = s;
    }
}
//双链表头插法
void createDlistF(DLNode *C, int a[], int n)
{
    DLNode *s;
    int i;
    C = (DLNode*)malloc(sizeof(DLNode));
    C->next = NULL;
    C->prior = NULL;
    for (i=0; i<n; ++i) {
        s = (DLNode*)malloc(sizeof(DLNode));
        s->data = a[i];
        s->next = C->next;
        C->next = s;
        s->prior = C;
        if (s->next != nil) {
            s->next->prior = s;
        }
    }
}

@end
