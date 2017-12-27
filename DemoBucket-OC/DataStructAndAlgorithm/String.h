//
//  String.h
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/25.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface String : NSObject
/*串：
 由零个或者多个字符组成的有限序列。串中任意连续字符组成的子序列称为该串的子串，包含子串的串称为主串，由一个或者多个空格组成的串称为空格串。
 串的存储结构：*/
//1. 定长顺序存储表示
#define maxSize 100
typedef struct
{
    char str[maxSize+1];
    int length;
}StrUM;
//2. 变长分配存储表示\动态分配表示
typedef struct
{
    char *ch;
    int length;
}StrMutable;
//串的基本操作：
//1. 赋值操作
int strAssign(StrMutable *strM, char *ch);

//2. 取串长度操作
int strLength(StrMutable strM);

//3. 串比较操作
int strCompare(StrMutable s1, StrMutable s2);

//4. 串连续操作
int concat(StrMutable *strM, StrMutable str1, StrMutable str2);

//5. 求子串操作
int substring(StrMutable *substrM, StrMutable str, int pos, int len);

//6. 串清空操作
int clearString(StrMutable *strM);

//串的模式匹配算法
//对一个串中某子串的定位操作称为串的模式匹配，其中待定位的子串称为模式串。
//简单模式匹配算法
int indexSubstr(StrMutable str, StrMutable substr);

//KMP算法
void getNext(StrMutable substr, int next[]);
int KMP(StrMutable str, StrMutable substr, int next[]);

//KMP算法的改进
void getNextVal(StrMutable substr, int nextVal[]);
@end
