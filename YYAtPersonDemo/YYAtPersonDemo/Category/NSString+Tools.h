//
//  NSString+Tools.h
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/11.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Tools)

- (CGSize )getSizeWithFont:(UIFont *)font constrainedWidth:(CGFloat)width numberOfLines:(NSInteger)numberOfLines;

@end
