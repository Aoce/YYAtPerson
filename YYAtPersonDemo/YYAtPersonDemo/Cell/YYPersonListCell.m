//
//  YYPersonListCell.m
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/11.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "YYPersonListCell.h"
#import "YYPersonItem.h"
#import "UIView+Tools.h"

@interface YYPersonListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation YYPersonListCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *identifier = @"YYPersonListCell";
    YYPersonListCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYPersonListCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setRawObject:(id)rawObject {
    _rawObject = rawObject;
    
    if ([rawObject isKindOfClass:[YYPersonItem class]]) {
        YYPersonItem *personItem = rawObject;
        self.nameLabel.text = personItem.name;
        self.avatarImageView.clipsToBounds = YES;
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.width/2;
        self.avatarImageView.layer.masksToBounds = YES;
        self.avatarImageView.image = [UIImage imageNamed:@"icon_white_default_avatar"];
    }
}

@end
