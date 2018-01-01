//
//  ViewController.m
//  sort
//
//  Created by 韩冲 on 2017/12/31.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *ary = [@[@9, @6, @3, @1, @4, @8, @2, @5, @7] mutableCopy];
    ary = [self bubble_sort:ary]; // 直接插入 希尔 冒泡 快排 选择 堆排 归并 基数
    NSString *str = @"ary --->>> ";
    for (NSNumber *num in ary) {
        str = [NSString stringWithFormat:@"%@, %d", str, [num intValue]];
    }
    NSLog(@"%@", str);
}

// **************   insert_sort   **************
- (NSMutableArray *)insert_sort:(NSMutableArray *)a start:(int)start end:(int)end
{
    for (int i = start; i < end; i ++) {
        if (a[i] < a[i - start]) {
            int x = [a[i] intValue];
            int j = i - start;
            a[i] = a[j];
            while (j >= 0 && x < [a[j] intValue]) {
                a[j + start] = a[j];
                j -= start;
            }
            a[j + start] = @(x);
        }
    }
    return a;
}

// **************   hell_sort   **************
- (NSMutableArray *)hell_sort:(NSMutableArray *)a
{
    int start = (int)a.count/2;
    while (start >= 1) {
        [self insert_sort:a start:start end:(int)a.count];
        start = start/2;
    }
    return a;
}

// **************   select_sort   **************
- (NSMutableArray *)select_sort:(NSMutableArray *)a
{
    for (int i = 0; i < a.count; i ++) {
        int x = [a[i] intValue];
        int index = i;
        for (int j = i + 1; j < a.count; j ++) {
            if ([a[j] intValue] < x) {
                x = [a[j] intValue];
                index = j;
            }
        }
        int temp = [a[i] intValue];
        a[i] = a[index];
        a[index] = @(temp);
    }
    return a;
}

// **************   heap_sort   **************
- (NSMutableArray *)heap_sort:(NSMutableArray *)a
{
    for (int i = ((int)a.count -  1)/2; i >= 0; --i) {
        a = [self heapAdjust:a start:i length:(int)a.count];
    }
    for (int i = (int)a.count - 1; i >= 0; -- i) {
        int tmp = [a[i] intValue];
        a[i] = a[0];
        a[0] = @(tmp);
        a = [self heapAdjust:a start:0 length:i];
    }
    return a;
}


- (NSMutableArray *)heapAdjust:(NSMutableArray *)a start:(int)start length:(int)length
{
    int tmp = [a[start] intValue];
    int child = 2*start + 1;
    while (child < length) {
        if (child + 1 < length && a[child] < a[child + 1]) {
            ++ child;
        }
        if (a[start] < a[child]) {
            a[start] = a[child];
            start = child;
            child = 2 * start + 1;
        }
        else {
            break;
        }
        a[start] = @(tmp);
    }
    return a;
}

// **************   bubble_sort   **************
- (NSMutableArray *)bubble_sort:(NSMutableArray *)a
{
    for (int i = 1; i < (int)a.count; i ++) {
        for (int j = 0; j < (int)a.count - i; j ++) {
            if (a[j] > a[j + 1]) {
                int tmp = [a[j] intValue];
                a[j] = a[j + 1];
                a[j + 1] = @(tmp);
            }
        }
    }
    return a;
}

@end
