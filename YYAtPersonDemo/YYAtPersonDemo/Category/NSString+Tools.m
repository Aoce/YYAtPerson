//
//  NSString+Tools.m
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/11.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "NSString+Tools.h"
#import <objc/runtime.h>
#import "UIView+Tools.h"

static const NSString *KEY_REUSELABEL = @"KreuseLabel";

@implementation NSString (Tools)

- (UILabel *)reuseLabel{
    UILabel *reuseLabel = objc_getAssociatedObject(self, &KEY_REUSELABEL);
    return reuseLabel;
}

- (void)setReuseLabel:(UILabel *)reuseLabel{
    objc_setAssociatedObject(self, &KEY_REUSELABEL, reuseLabel , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize )getSizeWithFont:(UIFont *)font constrainedWidth:(CGFloat)width numberOfLines:(NSInteger)numberOfLines{
    if (width == 0) {
        width = 1000;
    }
    if (self.reuseLabel == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
        self.reuseLabel = label;
    }
    self.reuseLabel.width = width;
    self.reuseLabel.text = self;
    self.reuseLabel.font = font;
    self.reuseLabel.numberOfLines = numberOfLines;
    [self.reuseLabel sizeToFit];
    CGSize size = self.reuseLabel.frame.size;
    return size;
}


@end
