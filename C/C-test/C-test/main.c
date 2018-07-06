//
//  main.c
//  C-test
//
//  Created by lingda on 2018/6/21.
//  Copyright © 2018年 lingda. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[]) {
    int i , j ;
    unsigned int Array_A[32];
    unsigned int * pPointer;
    i = 0x0008 ;
    //测试i
    printf("i=%d\n",i) ;
    
    pPointer = Array_A ;
    *(pPointer++)=i++ ;
    //测试i
    printf("i=%d\n",i) ;
    
    j= Array_A[0];
    printf("#j:%d\n",j);   //#
    *(pPointer) = i ;
    j = Array_A[1];
    printf("##j:%d\n",j);   //##
    
    return 0;
}
