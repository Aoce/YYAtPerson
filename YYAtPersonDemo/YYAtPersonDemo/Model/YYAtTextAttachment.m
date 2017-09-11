//
//  JMAtTextAttachment.m
//  Jiemo
//
//  Created by Ace on 16/12/6.
//  Copyright © 2016年 Longbeach. All rights reserved.
//

#import "YYAtTextAttachment.h"

@implementation YYAtTextAttachment
//根据自己的字体大小需求微调
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex {
    return CGRectMake(0, -3, _imageSize.width, _imageSize.height);
}
@end
