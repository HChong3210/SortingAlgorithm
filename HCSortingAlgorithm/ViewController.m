//
//  ViewController.m
//  HCSortingAlgorithm
//
//  Created by HChong on 2018/4/9.
//  Copyright © 2018年 HChong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@(12), @(3), @(16), @(2), @(11), @(20), @(8), @(1), @(10), @(5), @(7), @(14), @(15), @(9)]];
    
    
//    [self quickSortArray:array formLeft:0 right:array.count - 1];
//    NSLog(@"快排--------------------------%@", array);
    
    
    [self mergeSortArray:array];
    NSLog(@"归并排序--------------------------%@", array);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 快排
- (void)quickSortArray:(NSMutableArray *)array formLeft:(NSInteger)left right:(NSInteger)right {
    if (left >= right) {
        return;
    }
    NSInteger i = left;
    NSInteger j = right;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        //从右基准数开始向左递减, 直到一个数小于基准数(先从右边开始遍历是为了保持基准数不变)
        while (i < j && [array[j] integerValue] >= key) {
            j--;
        }
        //从左基准位置开始向右递增, 直到遇到一个数大于基准数
        while (i < j && [array[i] integerValue] <= key) {
            i++;
        }
        //交换两个数在数组中的位置
        if (i < j) {
            array[i] = @([array[i] integerValue] + [array[j] integerValue]);
            array[j] = @([array[i] integerValue] - [array[j] integerValue]);
            array[i] = @([array[i] integerValue] - [array[j] integerValue]);
        }
    }

    //此时, 两个基准数相等, 将基准数归位
    array[left] = array[i];
    array[i] = @(key);
    
    //递归处理基准数左边
    [self quickSortArray:array formLeft:left right:i - 1];
    //递归处理基准数右边
    [self quickSortArray:array formLeft:i + 1 right:right];
}

#pragma mark - 归并排序
- (void)mergeSortArray:(NSMutableArray *)array {
    //创建一个副本数组
    NSMutableArray * auxiliaryArray = [[NSMutableArray alloc]initWithCapacity:array.count];
    
    //对数组进行第一次二分，初始范围为0到array.count-1
    [self mergeSort:array auxiliary:auxiliaryArray low:0 high:array.count-1];
}

- (void)mergeSort:(NSMutableArray *)array auxiliary:(NSMutableArray *)auxiliaryArray low:(NSInteger)low high:(NSInteger)high {
    //递归跳出判断
    if (low >= high) {
        return;
    }
    //对分组进行二分
    NSInteger middle = (high - low) / 2 + low;
    
    //对左侧的分组进行递归二分 low为第一个元素索引，middle为最后一个元素索引
    [self mergeSort:array auxiliary:auxiliaryArray low:low high:middle];
    
    //对右侧的分组进行递归二分 middle+1为第一个元素的索引，high为最后一个元素的索引
    [self mergeSort:array auxiliary:auxiliaryArray low:middle + 1 high:high];
    
    //对每个有序数组进行回归合并
    [self merge:array auxiliary:auxiliaryArray low:low middel:middle high:high];
}

- (void)merge:(NSMutableArray *)array auxiliary:(NSMutableArray *)auxiliaryArray low:(NSInteger)low middel:(NSInteger)middle high:(NSInteger)high {
    //将数组元素复制到副本
    for (NSInteger i=low; i<=high; i++) {
        auxiliaryArray[i] = array[i];
    }
    //左侧数组标记
    NSInteger leftIndex = low;
    //右侧数组标记
    NSInteger rightIndex = middle + 1;
    
    //比较完成后比较小的元素要放的位置标记
    NSInteger currentIndex = low;
    
    while (leftIndex <= middle && rightIndex <= high) {
        //此处是使用NSNumber进行的比较，你也可以转成NSInteger再比较
        if ([auxiliaryArray[leftIndex] compare:auxiliaryArray[rightIndex]]!=NSOrderedDescending) {
            //左侧标记的元素小于等于右侧标记的元素
            array[currentIndex] = auxiliaryArray[leftIndex];
            currentIndex++;
            leftIndex++;
        } else {
            //右侧标记的元素小于左侧标记的元素
            array[currentIndex] = auxiliaryArray[rightIndex];
            currentIndex++;
            rightIndex++;
        }
    }
    //如果完成后左侧数组有剩余
    if (leftIndex <= middle) {
        for (NSInteger i = 0; i<=middle - leftIndex; i++) {
            array[currentIndex +i] = auxiliaryArray[leftIndex +i ];
        }
    }
}

@end
