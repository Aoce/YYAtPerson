//
//  NSAttributedString+YY.m
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/11.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "NSAttributedString+YY.h"
#import "YYAtTextAttachment.h"

@implementation NSAttributedString (YY)

- (NSArray *)getCurrentAtPersonItems {
    __block NSMutableArray *personItems = [NSMutableArray new];
    [self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if (value && [value isKindOfClass:[YYAtTextAttachment class]]) {
            YYAtTextAttachment *textAttachment = value;
            if (textAttachment.personItem) {
                [personItems addObject:textAttachment.personItem];
            }
        }
    }];
    
    return personItems;
}

@end
