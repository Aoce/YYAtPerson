//
//  JMTransformAtHandler.h
//  Jiemo
//
//  Created by Ace on 16/5/6.
//  Copyright © 2016年 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYTransformAtHandler : NSObject

@property (nonatomic, assign) BOOL hasEmoji;
@property (nonatomic, assign) NSInteger headLength;

@property (nonatomic, strong) NSArray *links;
@property (nonatomic, copy) NSString *caption;


- (void)transformAtWithContent:(NSString *)content
                     atPersons:(NSArray *)atPersons
                       isAtAll:(BOOL)isAtAll
                 andHeadLength:(NSUInteger)headLength;

- (void)transformTopicWithContent:(NSString *)content
                           topics:(NSArray *)topics
                    andHeadLength:(NSUInteger)headLength;

- (void)transformAtWithContent:(NSString *)content
                     atPersons:(NSArray *)atPersons
                       isAtAll:(BOOL)isAtAll
                        topics:(NSArray *)topics
                 andHeadLength:(NSUInteger)headLength;
@end
