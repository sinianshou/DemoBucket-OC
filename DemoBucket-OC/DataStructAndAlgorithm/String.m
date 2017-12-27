//
//  String.m
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/25.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import "String.h"

@implementation String

//串的基本操作：
//1. 赋值操作
int strAssign(StrMutable *strM, char *ch)
{
    StrMutable str = *strM;
    if(str.ch)
        free(str.ch);
    int len = 0;
    char *c = ch;
    while(*c)
    {
        ++len;
        ++c;
    }
    if(len == 0)
    {
        str.ch = NULL;
        str.length = 0;
        return 1;
    }else
    {
        str.ch = (char*)malloc(sizeof(char)*(len+1));
        if(str.ch == NULL)
            return 0 ;
        else{
            c = ch;
            for(int i=0;i<=len;++i,++c)
                str.ch[i] = *c;
            str.length = len;
            return 1;
        }
    }
}

//2. 取串长度操作
int strLength(StrMutable strM)
{
    return strM.length;
}

//3. 串比较操作
int strCompare(StrMutable s1, StrMutable s2)
{
    for(int i=0;i<s1.length && i<s2.length;++i)
        if(s1.ch[i] != s2.ch[i])
            return s1.ch[i] - s2.ch[i];
    return s1.length - s2.length;
}

//4. 串连续操作
int concat(StrMutable *strM, StrMutable str1, StrMutable str2)
{
    StrMutable str = *strM;
    if(str.ch)
    {
        free(str.ch);
        str.ch = NULL;
    }
    str.ch = (char*)malloc(sizeof(char)*(str1.length+str2.length));
    if(str.ch == NULL)
        return 0;
    int i = 0;
    while(i<=str1.length)
    {
        str.ch[i] = str1.ch[i];
        ++i;
    }
    int j = 0;
    while(j<str2.length)
    {
        str.ch[i+j] = str2.ch[j];
        ++j;
    }
    str.length = str1.length+str2.length;
    return 1;
}

//5. 求子串操作
int substring(StrMutable *substrM, StrMutable str, int pos, int len)
{
    StrMutable substr = *substrM;
    if(pos<0 || pos>=str.length ||len<0 || len>str.length-pos)
        return 0;
    if(substr.ch)
    {
        free(substr.ch);
        substr.ch = NULL;
    }
    if(len==0)
    {
        substr.ch = NULL;
        substr.length = 0;
        return 1;
    }else
    {
        substr.ch = (char*)malloc(sizeof(char)*len);
        int i = pos;
        int j = 0;
        while(i<pos+len)
        {
            substr.ch[j] = str.ch[i];
            ++i;
            ++j;
        }
        substr.ch[j] = '\0';
        substr.length = len;
        return 1;
    }
}

//6. 串清空操作
int clearString(StrMutable *strM)
{
    StrMutable str = *strM;
    if(str.ch)
    {
        free(str.ch);
        str.ch = NULL;
    }
    str.length = 0;
    return 1;
}

//串的模式匹配算法
//对一个串中某子串的定位操作称为串的模式匹配，其中待定位的子串称为模式串。
//简单模式匹配算法
int indexSubstr(StrMutable str, StrMutable substr)
{
    int i=1,j=1,k=i;
    while(i<=str.length && j<=substr.length)
    {
        if(str.ch[i] == substr.ch[j])
        {
            ++i;
            ++j;
        }else
        {
            j = 1;
            i = ++k;
        }
    }
    if(j>substr.length)
        return k;
    else return 0;
}

//KMP算法
void getNext(StrMutable substr, int next[])
{
    int i=1,j=0;
    next[1] = 0;
    while(i < substr.length)
    {
        if(j == 0 || substr.ch[i] == substr.ch[j])
        {
            ++i;
            ++j;
            next[i] = j;
        }else
            j = next[j];
    }
}
int KMP(StrMutable str, StrMutable substr, int next[])
{
    int i = 1, j = 1;
    while(i<=str.length && j<=substr.length)
    {
        if(j==0 || str.ch[i] == substr.ch[j])
        {
            ++i;
            ++j;
        }else
        {
            j = next[j];
        }
    }
    if(j>substr.length)
        return i-substr.length;
    else
        return 0;
}

//KMP算法的改进
void getNextVal(StrMutable substr, int nextVal[])
{
    int i=1,j=0;
    nextVal[0] = 0;
    while(i<substr.length)
    {
        if(j==0 || substr.ch[i]==substr.ch[j])
        {
            ++i;
            ++j;
            if(substr.ch[i] != substr.ch[j])
                nextVal[i] = j;
            else
                nextVal[i] = nextVal[j];
        }else
            j = nextVal[j];
    }
}
@end

