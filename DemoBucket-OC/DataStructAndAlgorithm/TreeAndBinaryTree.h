//
//  TreeAndBinaryTree.h
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/29.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeAndBinaryTree : NSObject
/*
 树的定义
 树是若干结点（A、B、C等均为结点）的集合，是由唯一的根（结点A）和若干颗互不相交的子树（如B、E、F、K、L这5个结点组成的树就是一颗子树）组成的。
 当树的结点数目为0时，则称之为空树。
 二叉树主要性质
 1. 非空二叉树上叶子结点数等于双分支结点数加1
 2. 二叉树的第i层上最多有2i-1(i>=1)个结点
 3. 高度（或者深度）为k的二叉树最多有2k-1（k>=1）个结点。换句话说，满二叉树中前k层的结点个数为2k-1
 4. 有n个结点的完全二叉树，对各节点从上到下，从左到右依次编号（编号范围为1~n），则结点之间有如下关系
 a. 编号i != 1的结点a，其双亲结点的编号为 i/2
 b. 若 2*i <= n，则 a 左孩子的编号为 2i ，若 2*i > n，则 a 无左孩子
 c. 若 2*i+1 <= n，则 a 右孩子的编号为 2*i+1 ，若 2*i+1 > n ，则 a 无右孩子
 5. 函数 Catalan()：给定 n 个结点，能构成 h(n) 种不同的二叉树，h(n) = Cn2n/(n+1)
 6. 具有 n（n >= 1）个结点的完全二叉树的高度（深度）为 |log2n|+1
 
 二叉树的存储结构
 顺序存储结构
 BTree[]   =
 结点        A    B    C    D    E
 数组下标    0    1    2    3    4    5
 例如知道了定点A的下标为1，要得到A的做孩子结点只需访问 BTree[1*2] 即可，类似的，如果知道了一个结点 i ，如果 2i 不大于 n ，则 i 的左孩子结点就存在于 BTree[2*i] 内。*/
//链式存储结构
typedef struct BTNode
{
    int data;
    struct BTNode *lchild;
    struct BTNode *rchild;
}BTNode;
//BTNode *BT = (BTNode *)malloc(sizeof(BTNode));

void Visit(BTNode *p);

//二叉树的便利算法
//先序遍历
void Preorder(BTNode *p);
//中序遍历
void Inorder(BTNode *p);
//后序遍历
void Postorder(BTNode *p);


//程序模板：
void trave(BTNode *p);
/*
 先序遍历输出：A B C D E F G H
 中序遍历输出：C B E D F A H G
 后序遍历输出：C E F D B H G A
 */
//层次遍历
void level(BTNode *p);

//二叉树遍历算法的改进
//递归函数比较低效，原因在于系统帮助调用了一个栈并做了诸如保护现场和恢复现场等复杂的操作，才使得遍历可以用非常简洁的代码实现。
//二叉树深度优先遍历算法的非递归实现
//1. 先序遍历
void preorderNonrecursion(BTNode *bt);
//2. 中序遍历
void inorderNonrecursion(BTNode *bt);

//3. 后序遍历
void postorderNonrecursion(BTNode *bt);
/*
 线索二叉树
 中序线索二叉树的构造
 lchild    ltag    data    rtag    rchild
 */
typedef struct TBTNode
{
    char data;
    int ltag,rtag;
    struct TBTNode *lchild;
    struct TBTNode *rchild;
}TBTNode;


void VisitTBTNode(TBTNode *bt);

//中序遍历对二叉树线索化的递归算法如下
void InThread(TBTNode *p, TBTNode *pre);
//主程序中序遍历中序线索二叉树
void createInThread(TBTNode *root);
//遍历中序线索二叉树
TBTNode *First(TBTNode *p);
TBTNode *Next(TBTNode *p);
void InorderTBTNode(TBTNode *root);
//前序线索二叉树
void preThreadTBTNode(TBTNode *p, TBTNode *pre);
//在前序线索二叉树上执行中序遍历的算法如下
void preorderTBTNode(TBTNode *root);
//后序线索二叉树
void postThread(TBTNode *p, TBTNode *pre);
/*
 说明：对于后序线索二叉树的遍历，一般多为手工找出当前节点的后继，因此可记住以下三点：
 1. 若节点x是二叉树的跟，则后继为空
 2. 若节点x是其双亲的右孩子，或是其双亲的左孩子且其双亲没有右子树，则其后继即为双亲节点
 3. 若节点x是其双亲的左孩子，且其双亲有右子树，则其后继为双亲右子树上按后序遍历出的第一个节点
 */
/*
 树和森林的遍历
 
 1. 树的遍历
 a. 先序遍历
 i. 访问根节点A
 ii. 访问A的第一棵子树，访问子树时先访问根节点B
 iii. 访问B的第一个孩子E
 iv. 访问B的第二个孩子F
 v. 访问A的第二棵子树，访问子树时先访问根节点C
 vi. 访问C的第一个孩子G
 vii. 访问A的第三棵子树，访问子树时先访问根节点D
 viii. 访问D的第一个孩子H
 ix. 访问D的第二个孩子I
 x. 访问D的第三个孩子J
 现需遍历的结果为：ABEFCGDHIJ
 
 b. 后序遍历
 i. 访问根节点A的第一棵子树，访问子树时先访问根节点B的第一个孩子E
 ii. 访问B的第二个孩子F
 iii. 访问B
 iv. 访问A的第二棵子树，访问子树时先访问根节点C的第一个孩子G
 v. 访问C
 vi. 访问A的第三课子树，访问子树时先访问根节点D的第一个孩子H
 vii. 访问D的第二个孩子I
 viii. 访问D的第三个孩子J
 ix. 访问D
 x. 最后访问根节点A
 后序遍历的结果为：EFBGCHIJDA
 
 2. 森林的遍历
 a. 先序遍历
 先访问森林中第一棵树的根节点，然后先序遍历第一棵树中根节点的子树，最后先序遍历森林中除第一棵树意外的其他树
 b. 后序遍历
 后序遍历第一棵树中根节点的子树，然后访问第一棵树根节点，最后后序遍历森林中除第一棵树以后的森林。
 */

@end
