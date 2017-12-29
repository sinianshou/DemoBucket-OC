//
//  Array_Matrice_GeneralizedTable.h
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/28.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Array_Matrice_GeneralizedTable : NSObject

/*
数组
常用的两种数组的逻辑表示
一维数组：(a0, a1, ..., an-1)
二维数组：[(a0,0, a0,1, ..., a0,n-1),
      (a1,0, a1,1, ..., a1,n-1),
      ...,
      (an-1,0, an-1,1, ..., an-1,n-1)]

矩阵
Amn =          a0,0   a0,1   ...   a0,n-1
a1,0   a1,1   ...   a1,n-1
...
am-1,0 am-1,1... am-1,n-1
*/

#define maxSize 100
//矩阵的转置
void trsmat(int A[][maxSize], int B[][maxSize], int m, int n);
//矩阵相加
void addMat(int C[][maxSize], int A[][maxSize], int B[][maxSize], int m, int n);
//矩阵相乘
void mutmat(int C[][maxSize], int A[][maxSize], int B[][maxSize], int m, int n, int k);
/*
特殊矩阵
对称矩阵：满足 ai,j = aj,i 的矩阵称为对称矩阵。
a0,0
a1,0    a1,1
a2,0    a2,1   a2,2
......
an-1,0    an-1,1    .....    an-1,n-1

对称矩阵在一维数组中的表示
a0,0     a1,0     ...    an-1,0     an-1,1     ...    an-1,n-1
0    1    ...    n*(n-1)2    n*(n-1)2+1    ...    n*(n+1)/2-1

三角阵：上/下三角阵为矩阵下/上三角（不包括对角线）元素全为 c（c 可为 0）的矩阵。
a0,0     a1,0     ...    an-1,0     an-1,1     ...    an-1,n-1    c
0    1    ...    n*(n-1)2    n*(n-1)2+1    ...    n*(n+1)/2-1    n*(n+1)/2
对角矩阵：除主对角线以及其上下两条带状区域内的元素外，其余元素皆为 c（c 可为 0）的矩阵。
a0,0    a0,1     c       ....              c
a1,0    a1,1   a1,1        c          .....         c
c        a2,1   a2,2    a2,3       ....           c
......
c          .....  c        an-1,n-2    an-1,n-1
当 i = 1时， 带状区域的第一个元素为矩阵的第一个元素，其在一维数组中的下标为 0；
当 i > 1时， 第 i 行之前的元素个数为 2+(i-2)*3，则带状区域内的第一个元素在一维数组中的下标为 2+(i-2)*3。
*/
//稀疏矩阵
//常用的稀疏矩阵顺序存储以及相关操作
//三元组表示法
typedef struct
{
    int val;
    int i,j;
}trimat;
//Trimat trimat[maxterms];      //int trimat[maxterms][3]; 简单声明
//伪地址表示法
//1. 邻接表表示法
//
//
//2. 十字链表表示法
//普通节点结构定义
typedef struct OLNode
{
    int row,col;
    struct OLNode *right, *down;
    float val;
}OLNode;
//头结点结构定义
typedef struct
{
    OLNode *rhead, *chead;
    int m, n, k;
}CrossList;
//创建十字链表存储结构
int sreateCrossListMat(float A[][maxSize], int m, int n, int k, CrossList *Mpointer);
/*
 广义表：表元素可以是原子或者广义表的一种线性表的扩展结构。
 例子：
 1. A = ()，A是一个空表，长度为0，深度为1.
 2. B = (d, e)，B的元素全是原子，即d和e，长度为2，深度为1.
 3. C = (b, (c, d))，C有两个元素，分别是b和另一个广义表(c, d)，长度为2，深度为2.
 4. D = (B, C)，D的元素全是广义表，即B和C，长度为2，深度为3.
 5. E = (a, E)，E有两个元素，分别是原子和E本身，长度为2，深度为无限。
 广义表的长度：为表中最上层元素的个数。
 广义表的深度：为表中括号的最大层数。
 表头（Head）和表尾（Tail）：广义表非空时，第一个元素为广义表表头，其余元素组成的表示广义表的表尾。
 广义表节点：标记域（1表示为广义表节点），头指针域，尾指针域
 原子节点：标记域（0表示为原子节点），数据域，尾指针域

 */
@end
