//
//  IndexTableView.m
//  UITableView
//
//  Created by chenlong on 2019/9/2.
//  Copyright © 2019 langke. All rights reserved.
//

#import "IndexTableView.h"
#import "ViewReusePool.h"

@interface IndexTableView ()
{
	UIView *containerView;
	ViewReusePool *reusePool;
}
@end

@implementation IndexTableView

- (void)reloadData {
	[super reloadData];
	
	if (!containerView) {
		containerView = [UIView new];
		containerView.backgroundColor = [UIColor whiteColor];
		// 避免索引条随着tableview滚动
		[self.superview insertSubview:containerView aboveSubview:self];
	}
	
	if (!reusePool) {
		reusePool = [ViewReusePool new];
	}
	
	// 标记所有视图为可重用状态
	[reusePool reset];
	
	// reload字母索引条
	[self reloadIndexedBar];
	
}

- (void)reloadIndexedBar
{
	// 获取字母索引条的显示内容
	NSArray <NSString *> *arrayTitles = nil;
	if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
		arrayTitles = [self.indexedDataSource indexTitlesForIndexTableView:self];
	}
	
	// 判断字母索引条是否存在
	if (!arrayTitles || arrayTitles.count <= 0) {
		containerView.hidden = YES;
		return;
	}
	
	NSUInteger count = arrayTitles.count;
	CGFloat buttonWidth = 60;
	CGFloat buttonHeight = self.frame.size.height / count;
	
	for (int i = 0; i < count; i++) {
		NSString *title = [arrayTitles objectAtIndex:i];
		// 从重用池当中取出一个button来
		UIButton *button = (UIButton *)[reusePool dequeueReuseableView];
		// 没有可重用的button重新创建一个
		if (!button) {
			button = [UIButton new];
			button.backgroundColor = [UIColor whiteColor];
			// 注册button到重用池当中
			[reusePool addUsingView:button];
			NSLog(@"新创建一个button");
		} else {
			NSLog(@"button重用了");
		}
		
		// 添加button到父视图控件
		[containerView addSubview:button];
		[button setTitle:title forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		button.frame = CGRectMake(0, i * buttonHeight, buttonWidth, buttonHeight);
	}
	
	containerView.hidden = NO;
	containerView.backgroundColor = [UIColor orangeColor];
	containerView.frame = CGRectMake(
									 self.frame.origin.x + self.frame.size.width - buttonWidth,
									 self.frame.origin.y,
									 buttonWidth,
									 self.frame.size.height
									 );
	
}

@end
