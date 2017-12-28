//
//  Array_Matrice_GeneralizedTable.m
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/28.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import "Array_Matrice_GeneralizedTable.h"

@implementation Array_Matrice_GeneralizedTable

void trsmat(int A[][maxSize], int B[][maxSize], int m, int n)
{
    for(int i=0; i<m; ++i)
        for(int j=0; j<n; ++j)
            B[j][i] = A[i][j];
}

void addMat(int C[][maxSize], int A[][maxSize], int B[][maxSize], int m, int n)
{
    for(int i=0; i<m; ++i)
        for(int j=0; j<n; ++j)
            C[i][j] = A[i][j] + B[i][j];
}

void mutmat(int C[][maxSize], int A[][maxSize], int B[][maxSize], int m, int n, int k)
{
    for(int i=0; i<m; ++i)
        for(int j=0; j<k; ++j)
        {
            C[i][j] = 0;
            for(int h=0; h<n; ++h)
                C[i][j] += A[i][h] * B[h][j];
        }
}

int sreateCrossListMat(float A[][maxSize], int m, int n, int k, CrossList *Mpointer)
{
    CrossList  M = *Mpointer;
    if(M.rhead)
        free(M.rhead);
    if(M.chead)
        free(M.chead);
    M.m = m;
    M.n = n;
    M.k = k;
    /*申请头结点数组空间*/
    if(!(M.rhead = (OLNode*)malloc(sizeof(OLNode)*m)))
        return 0;
    if(!(M.chead = (OLNode*)malloc(sizeof(OLNode)*n)))
        return 0;
    /*头结点数组 right 和 down 指针置空*/
    for(int i=0; i<m; ++i)
    {
        M.rhead[i].right = NULL;
        M.rhead[i].down = NULL;
    }
    for(int i=0; i<n; ++i)
    {
        M.chead[i].right = NULL;
        M.chead[i].down = NULL;
    }
    OLNode *temp_r[maxSize];     //建立列链表的辅助指针数组
    for(int j=0; j<n; ++j)
        temp_r[j] = &(M.chead[j]);
    for(int i=0; i<m; ++i)
    {
        OLNode *c = &(M.rhead[i]);
        for(int j=0; j<n; ++j)
        {
            if(A[i][j] != 0)
            {
                OLNode *p = (OLNode*)malloc(sizeof(OLNode));
                p->row = i;
                p->col = j;
                p->val = A[i][j];
                p->down = NULL;
                p->right = NULL;
                c->right = p;
                c = p;
                temp_r[j]->down = p;
                temp_r[j] = p;
            }
        }
    }
    return 1;
}

@end
