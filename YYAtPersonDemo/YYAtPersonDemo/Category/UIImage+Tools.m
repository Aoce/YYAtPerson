//
//  UIImage+Tools.m
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/11.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "UIImage+Tools.h"
#import "NSString+Tools.h"

@implementation UIImage (Tools)

+ (UIImage *)imageWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    CGSize size = CGSizeMake([string getSizeWithFont:font constrainedWidth:0 numberOfLines:1].width, font.pointSize + 3);
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSForegroundColorAttributeName:color};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    UIGraphicsBeginImageContextWithOptions(size, 0, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetCharacterSpacing(ctx, 10);
    
    CGContextSetTextDrawingMode (ctx, kCGTextFill);
    
    CGContextSetRGBFillColor (ctx, 255, 255, 255, 1);
    
    [attributedString drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
