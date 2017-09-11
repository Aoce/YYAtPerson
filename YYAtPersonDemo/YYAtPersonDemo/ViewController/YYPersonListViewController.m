//
//  YYPersonListViewController.m
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/8.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "YYPersonListViewController.h"
#import "YYPersonListCell.h"
#import "YYPersonItem.h"

@interface YYPersonListViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YYPersonListViewController

#pragma mark -
#pragma mark lazy load

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

#pragma mark -
#pragma mark Life cycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *footer = [[[NSBundle mainBundle] loadNibNamed:@"YYPersonListFooterView" owner:nil options:nil] lastObject];
    self.tableView.tableFooterView = footer;
    
    // load DataSource
    [self generateDatasource];
    
    [self updateNavigationBar:YES];
    
}

#pragma mark -
#pragma mark Navigation bar

- (void)updateNavigationBar:(BOOL)animate {
    
    self.title = @"选择要@的人";
    
    //left Bar button
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateHighlighted];
    [cancelButton setTitleColor:UIColorFromRGB(0x6cc158) forState:UIControlStateNormal];
    [cancelButton setTitleColor:UIColorFromRGB(0x6cc158) forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(leftBarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    UIBarButtonItem * leftSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (kScreenWidth <= 375) {
        leftSpacer.width = -16;
    }else {
        leftSpacer.width = -19;
    }
    
    [self.parentViewController.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:leftSpacer, leftBarButtonItem, nil]];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:leftSpacer, leftBarButtonItem, nil]];
}

#pragma mark -
#pragma mark bar action

- (void)leftBarButtonItemClick:(id)sender {
    if (self.cancelSelectedBolck) {
        self.cancelSelectedBolck(nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Datasource

- (void)generateDatasource {
    //数据源自行定义...
    NSDictionary *dataSourceDic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"persons" ofType:@"plist"]];
    NSArray *dataSourceArray = [dataSourceDic objectForKey:@"persons"];
    NSMutableArray *dataSource = [NSMutableArray new];
    [dataSourceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            YYPersonItem *item = [[YYPersonItem alloc] init];
            item.name = obj;
            [dataSource addObject:item];
        }
    }];
    self.dataSource = dataSource;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYPersonListCell *cell = [YYPersonListCell cellWithTableView:tableView];
    cell.rawObject = self.dataSource[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YYPersonItem *personItem = self.dataSource[indexPath.section];
    if (self.finishSelectedBlock) {
        self.finishSelectedBlock(personItem);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
