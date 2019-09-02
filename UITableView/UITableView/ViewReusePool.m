//
//  ViewReusePool.m
//  UITableView
//
//  Created by chenlong on 2019/9/2.
//  Copyright © 2019 langke. All rights reserved.
//

#import "ViewReusePool.h"

@interface ViewReusePool ()
// 等待使用的队列
@property (nonatomic, strong) NSMutableSet *waitUsedQueue;
// 使用中的队列
@property (nonatomic, strong) NSMutableSet *usingQueue;
@end

@implementation ViewReusePool

- (instancetype)init
{
	self = [super init];
	if (self) {
		_waitUsedQueue = [NSMutableSet set];
		_usingQueue = [NSMutableSet set];
	}
	return self;
}

- (UIView *)dequeueReuseableView {
	UIView *view = [_waitUsedQueue anyObject];
	if (!view) {
		return nil;
	}
	// 进行队列移动
	[_waitUsedQueue removeObject:view];
	[_usingQueue addObject:view];
	return view;
}

- (void)addUsingView:(UIView *)view {
	if (!view) {
		return;
	}
	// 添加视图到使用中的队列
	[_usingQueue addObject:view];
}

- (void)reset {
	UIView *view = nil;
	while ((view = [_usingQueue anyObject])) {
		// 从使用中队列移除
		[_usingQueue removeObject:view];
		// 添加到待使用的队列
		[_waitUsedQueue addObject:view];
	}
}

@end
