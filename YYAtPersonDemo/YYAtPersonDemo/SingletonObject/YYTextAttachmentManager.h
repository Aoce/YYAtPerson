//
//  JMTextAttachmentManager.h
//  Jiemo
//
//  Created by Ace on 16/12/27.
//  Copyright © 2016年 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^JMCompleteBlock)(NSMutableAttributedString *mutableAttributedString, NSRange selectedRange);

@interface YYTextAttachmentManager : NSObject

+ (YYTextAttachmentManager *)getInstance;


/*
 *  textView : your current use textView
 *
 *  tickedPersonItems : selected persons
 *
 *  atAllPersons : all persons (later extension need to...)
 * 
 *  canRepeat : YES or NO
 *
 *  needBack : YES or NO (if manual input , not click @ button)
 *
 *  color : UIColor (color about transform string to UIImage)
 *  
 *  attributes : NSAttributes (the textView attirbutes)
 *
 *  completeBlock.
 *
 */
- (void)transformTextWithTextView:(UITextView *)textView
                tickedPersonItems:(NSArray *)tickedPersonItems
                     atAllPersons:(NSArray *)atAllPersons
                        canRepeat:(BOOL)canRepeat
                         needBack:(BOOL)needBack
                            color:(UIColor *)color
                        attributes:(NSDictionary *)attributes
                    completeBlock:(JMCompleteBlock)completeBlock;

@end
