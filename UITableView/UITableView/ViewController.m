//
//  ViewController.m
//  UITableView
//
//  Created by chenlong on 2019/9/2.
//  Copyright © 2019 langke. All rights reserved.
//

#import "ViewController.h"
#import "IndexTableView.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, IndexedTableViewDataSource>
{
	IndexTableView *tableView;
	UIButton *button;
	NSMutableArray *dataSource;
}
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	button = [[UIButton alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 44)];
	button.backgroundColor = [UIColor redColor];
	[button setTitle:@"reloadTable" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	
	tableView = [[IndexTableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height - 88) style:UITableViewStylePlain];
	tableView.delegate = self;
	tableView.dataSource = self;
	tableView.indexedDataSource = self;
	[self.view addSubview:tableView];
	
	dataSource = [NSMutableArray array];
	for (int i = 0; i < 100; i++) {
		[dataSource addObject:@(i + 1)];
	}
}

- (void)buttonAction:(UIButton *)button
{
	NSLog(@"reloadData");
	[tableView reloadData];
}

- (NSArray<NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView
{
	static BOOL change = NO;
	if (change) {
		change = NO;
		return @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K"];
	} else {
		change = YES;
		return @[@"A", @"B", @"C", @"D", @"E", @"F"];
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *identifier = @"reuseId";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.textLabel.text = [dataSource[indexPath.row] stringValue];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 40;
}


@end
