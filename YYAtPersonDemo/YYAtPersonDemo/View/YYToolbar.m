//
//  YYPublishToolbar.m
//  Jiemo
//
//  Created by Ace on 16/5/3.
//  Copyright © 2016年 Longbeach. All rights reserved.
//

#import "YYToolbar.h"
#import "UIView+Tools.h"

static const CGFloat kMarginLeft    = 12.0;
static const CGFloat kMarginTop     = 10.0;
static const CGFloat kButtonWidth   = 22.0;

@interface YYToolbar ()

@property (nonatomic, strong) UIButton *atButton;

@end

@implementation YYToolbar
- (instancetype)initWithFrame:(CGRect)frame{
    self = [self initWithFrame:frame hiddenVideoButton:NO];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame hiddenVideoButton:(BOOL)hiddenVideoButton {
    self = [super initWithFrame:frame];
    if (self) {
        //  UI
        self.backgroundColor = RGBCOLOR(249, 249, 249);
        self.userInteractionEnabled = YES;
        
        // lineView
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        lineImageView.backgroundColor = [UIColor lightGrayColor];
        
        self.atButton = [[UIButton alloc] initWithFrame:ccr(kMarginLeft, kMarginTop, kButtonWidth, kButtonWidth)];
        [self.atButton setImage:[UIImage imageNamed:@"kb_toolbar_at_normal"] forState:UIControlStateNormal];
        [self.atButton setImage:[UIImage imageNamed:@"kb_toolbar_at_normal"] forState:UIControlStateNormal];
        [self.atButton addTarget:self action:@selector(atButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:lineImageView];
        [self addSubview:self.atButton];
        
    }
    
    return self;
}

#pragma mark -
#pragma mark Actions

- (void)atButtonPressed:(id)sender {
    if (self.atButtonPressedBlock) {
        self.atButtonPressedBlock(nil);
    }
}

@end
