//
//  ViewReusePool.h
//  UITableView
//
//  Created by chenlong on 2019/9/2.
//  Copyright © 2019 langke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewReusePool : NSObject

// 从重用池中取出一个可重用的view
- (UIView *)dequeueReuseableView;

// 向重用池中添加一个视图
- (void)addUsingView:(UIView *)view;

// 重置，将当前使用中的视图移动到可重用队列当中
- (void)reset;


@end

NS_ASSUME_NONNULL_END
