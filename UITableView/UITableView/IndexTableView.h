//
//  IndexTableView.h
//  UITableView
//
//  Created by chenlong on 2019/9/2.
//  Copyright © 2019 langke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexedTableViewDataSource <NSObject>
// 获取一个tableview的字母索引条数据的方法
- (NSArray <NSString *>*)indexTitlesForIndexTableView:(UITableView *)tableView;
@end

@interface IndexTableView : UITableView
@property (nonatomic, weak) id <IndexedTableViewDataSource> indexedDataSource;
@end

