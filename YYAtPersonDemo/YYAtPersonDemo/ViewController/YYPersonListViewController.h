//
//  YYPersonListViewController.h
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/8.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Defines.h"

@interface YYPersonListViewController : UITableViewController

@property (nonatomic, copy) YYBlock cancelSelectedBolck;
@property (nonatomic, copy) YYBlock finishSelectedBlock;

@end
