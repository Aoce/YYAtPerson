//
//  UIView+Tools.h
//  PMP
//
//  Created by Ace on 09/11/2017.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint RoundPoint(CGPoint p);
CGSize RoundSize(CGSize s);
CGRect RoundRect(CGRect r);
#define ccr(x, y, w, h) RoundRect(CGRectMake(x, y, w, h))
#define ccp(x, y) RoundPoint(CGPointMake(x, y))
#define ccs(w, h) RoundSize(CGSizeMake(w, h))

@interface UIView (Tools)


@property (nonatomic, readwrite)CGFloat top;
@property (nonatomic, readwrite)CGFloat bottom;
@property (nonatomic, readwrite)CGFloat left;
@property (nonatomic, readwrite)CGFloat right;
@property (nonatomic, readwrite)CGFloat middleX;
@property (nonatomic, readwrite)CGFloat middleY;
@property (nonatomic, readwrite)CGFloat width;
@property (nonatomic, readwrite)CGFloat height;
@property (nonatomic, readonly)CGPoint boundsCenter;
@property (nonatomic, readwrite)CGPoint leftTopPoint;


@property (nonatomic, readonly, getter = isOnWindow) BOOL onWindow;

- (void)removeAllSubviews;

- (void)normalize;
- (void)circlize;

- (void)addTestBorderLine;
- (void)addTestBorderLineWithColor:(UIColor *)borderColor;

- (void)pass;

@end


@interface UIView(TViewHiarachy)

@property (nonatomic,readonly)UIViewController *viewController;
- (UIViewController *) firstAvailableUIViewController;

@end


@interface UIView(TTouch)

- (void)addTarget:(id)target tapAction:(SEL)action;
- (void)addTarget:(id)target delegate:(id)delegate tapAction:(SEL)action;
- (void)addTarget:(id)target delegate:(id)delegate tapAction:(SEL)action numberOfTapsRequired:(NSInteger)numberOfTapsRequired;

@end


@interface UIView(TAutoresizing)

+ (UIViewAutoresizing)fullfillAutoresizing;

- (void)fullfillPrarentView;

@end

@interface UIView(TMask)

- (void)addMaskLayerWithImageName:(NSString *)imageName;
- (void)addMaskLayerWithImage:(UIImage *)image;
- (void)addMaskImageViewWithImageName:(NSString *)imageName;
@end

@interface UIView(TCell)

- (UITableViewCell *)findBelongToCell;

@end

//添加subview时controller被dismiss掉，在更新约束时会发生崩溃
//故在一些cell使用以下方式添加view
//from stack overflow
@interface UIView (AddSubviewWithRemovingFromParent)
- (void)addSubviewWithRemovingFromParent:(UIView *)view;
@end


