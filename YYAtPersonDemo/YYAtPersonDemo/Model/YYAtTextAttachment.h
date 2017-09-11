//
//  JMAtTextAttachment.h
//  Jiemo
//
//  Created by Ace on 16/12/6.
//  Copyright © 2016年 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYPersonItem;
@interface YYAtTextAttachment : NSTextAttachment

@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, copy) NSString *personId;

@property (nonatomic, strong) YYPersonItem *personItem;

@property (nonatomic, strong) NSArray *atAllPersons;

@end
