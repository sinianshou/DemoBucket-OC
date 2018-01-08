//
//  TreeAndBinaryTree.m
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/29.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import "TreeAndBinaryTree.h"

#define maxSize 100

@implementation TreeAndBinaryTree

void Visit(BTNode *p)
{
    printf("p.data is %d", p->data);
}

//二叉树的便利算法
//先序遍历
void Preorder(BTNode *p)
{
    if(p != NULL)
    {
        Visit(p);
        Preorder(p->lchild);
        Preorder(p->rchild);
    }
}
//中序遍历
void Inorder(BTNode *p)
{
    if(p != NULL)
    {
        Inorder(p->lchild);
        Visit(p);
        Inorder(p->rchild);
    }
}
//后序遍历
void Postorder(BTNode *p)
{
    if(p != NULL)
    {
        Postorder(p->lchild);
        Postorder(p->rchild);
        Visit(p);
    }
}


//程序模板：
void trave(BTNode *p)
{
    if(p != NULL)
    {
        //(1)
        trave(p->lchild);
        //(2)
        trave(p->rchild);
        //(3)
    }
}
//层次遍历
void level(BTNode *p)
{
    int front,rear;
    BTNode *que[maxSize];   //定义一个循环队列，用来记录将要访问的层次上的结点
    front = rear = 0;
    BTNode *q;
    if(p != NULL)
    {
        rear = (rear+1)%maxSize;
        que[rear] = p;
        while(front != rear)
        {
            front = (front + 1) % maxSize;
            q = que[front];
            Visit(q);
            if(q->lchild != NULL)
            {
                rear = (rear+1)%maxSize;
                que[rear] = q->lchild;
            }
            if(q->rchild != NULL)
            {
                rear = (rear+1)%maxSize;
                que[rear] = q->rchild ;
            }
        }
    }
}

//二叉树遍历算法的改进
//递归函数比较低效，原因在于系统帮助调用了一个栈并做了诸如保护现场和恢复现场等复杂的操作，才使得遍历可以用非常简洁的代码实现。
//二叉树深度优先遍历算法的非递归实现

//1. 先序遍历
void preorderNonrecursion(BTNode *bt)
{
    if(bt != NULL)
    {
        BTNode *Stack[maxSize];    //定义一个栈
        int top = -1;                             //初始化栈
        BTNode *p;
        Stack[++top] = bt;                  //根节点入栈
        while(top != -1)
        {
            p = Stack[top--];          //出栈并输出栈顶结点
            Visit(p);                         //Visit为访问p的函数
            if(p->rchild != NULL)   //栈顶结点的右孩子存在，则右孩子入栈
                Stack[++top] = p->rchild;
            if(p->lchild != NULL)    //栈顶结点的左孩子存在，则左孩子入栈
                Stack[++top] = p->lchild;
        }
    }
}
//2. 中序遍历
void inorderNonrecursion(BTNode *bt)
{
    if(bt != NULL)
    {
        BTNode *Stack[maxSize];
        int top = -1;
        BTNode *p;
        p = bt;
        /*
         下面的循环完成中序遍历
         */
        while(top != -1 || p != NULL)
        {
            while(p != NULL)
            {
                Stack[++top] = p;
                p = p->lchild;
            }
            while(top != -1)
            {
                p = Stack[top--];
                Visit(p);
                p = p->rchild;
            }
        }
    }
}

//3. 后序遍历
void postorderNonrecursion(BTNode *bt)
{
    if(bt != NULL)
    {
        BTNode *Stack1[maxSize];
        int top1 = -1;
        BTNode *Stack2[maxSize];
        int top2 = -1;
        BTNode *p = NULL;
        Stack1[++top1] = bt;
        while(top1 != -1)
        {
            p = Stack1[top1--];
            Stack2[++top2] = p;
            //注意下面两个if语句和先序遍历的区别，左右孩子的入栈顺序相反
            if(p->lchild != NULL)
                Stack1[++top1] = p->lchild;
            if(p->rchild != NULL)
                Stack1[++top1] = p->rchild;
        }
        while(top2 != -1)
        {
            //出栈序列即为后序遍历序列
            p = Stack2[top2--];
            Visit(p);     //Visit是访问p的函数
        }
    }
}

void VisitTBTNode(TBTNode *bt){
    printf("bt.data is %d", bt->data);
}

//中序遍历对二叉树线索化的递归算法如下
void InThread(TBTNode *p, TBTNode *pre){
    if(p != NULL){
        InThread(p->lchild, pre);
        if(p->lchild == NULL){
            p->lchild = p;
            p->ltag = 1;
        }
        if(pre != NULL && pre->rchild == NULL){
            p->rchild = p;
            pre->rtag = 1;
        }
        pre = p;
        p = p->rchild;
        InThread(p, pre);
    }
}
//主程序中序遍历中序线索二叉树
void createInThread(TBTNode *root){
    TBTNode *pre = NULL;
    if(root != NULL){
        InThread(root, pre);
        pre->rchild = NULL;
        pre->rtag = 1;
    }
}
//遍历中序线索二叉树
TBTNode *First(TBTNode *p){
    while(p->ltag == 0){
        p = p->lchild;
    }
    return p;
}
TBTNode *Next(TBTNode *p){
    if(p->rtag == 0)
        return First(p->rchild);
    else
        return p->rchild;
}
void InorderTBTNode(TBTNode *root){
    for(TBTNode *p=First(root); p!=NULL; p=Next(p) )
        VisitTBTNode(p);
}
//前序线索二叉树
void preThreadTBTNode(TBTNode *p, TBTNode *pre){
    if(p!=NULL){
        if(p->lchild == NULL){
            p->lchild = pre;
            p->ltag = 1;
        }
        if(pre!= NULL && pre->rchild == NULL){
            pre->rchild = p;
            pre->rtag = 1;
        }
        if(p->ltag == 0)
            preThreadTBTNode(p->lchild, pre);
        if(p->rtag == 0)
            preThreadTBTNode(p->rchild, pre);
    }
}
//在前序线索二叉树上执行中序遍历的算法如下
void preorderTBTNode(TBTNode *root){
    if(root != NULL){
        TBTNode *p = root;
        while(p != NULL){
            while(p->ltag == 0){
                VisitTBTNode(p);
                p = p->lchild;
            }
            VisitTBTNode(p);
            p = p->rchild;
        }
    }
}
//后序线索二叉树
void postThread(TBTNode *p, TBTNode *pre){
    if(p != NULL){
        postThread(p->lchild, pre);
        postThread(p->rchild, pre);
        if(p->lchild == NULL){
            pre->rchild = p;
            pre->rtag = 1;
        }
        pre = p;
    }
}
@end
