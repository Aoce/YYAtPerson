//
//  YYPersonListCell.h
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/11.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YYPersonListCell : UITableViewCell

@property (nonatomic, strong) id rawObject;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
