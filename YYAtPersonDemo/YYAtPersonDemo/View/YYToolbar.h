//
//  YYPublishToolbar.h
//  Jiemo
//
//  Created by Ace on 16/5/3.
//  Copyright © 2016年 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Defines.h"

@interface YYToolbar : UIView

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, copy) YYBlock atButtonPressedBlock;

@end
