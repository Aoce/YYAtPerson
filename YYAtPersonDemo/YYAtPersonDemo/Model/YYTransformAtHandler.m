//
//  JMTransformAtHandler.m
//  Jiemo
//
//  Created by Ace on 16/5/6.
//  Copyright © 2016年 Longbeach. All rights reserved.
//

#import "YYTransformAtHandler.h"
#import "YYPersonItem.h"

@interface YYTransformAtHandler ()

@end

@implementation YYTransformAtHandler

- (NSArray *)links {
    if (_links == nil) {
        _links = [NSArray array];
    }
    return _links;
}

- (void)transformAtWithContent:(NSString *)content
                     atPersons:(NSArray *)atPersons
                       isAtAll:(BOOL)isAtAll
                        topics:(NSArray *)topics
                 andHeadLength:(NSUInteger)headLength{
    self.caption = nil;
    self.links = nil;
    
    self.headLength = headLength;
    
    NSString *captionString = nil;
    if (content.length > 0) {
        captionString = content;
    }
    if ((atPersons == nil || atPersons.count==0) && !isAtAll && (topics == nil || topics.count==0)) {
        self.caption = content;
        return;
    }
    if (captionString.length > 0) {
        
        NSMutableDictionary *nameInfo = [NSMutableDictionary dictionary];
        
        [atPersons enumerateObjectsUsingBlock:^(YYPersonItem *obj, NSUInteger idx, BOOL *stop) {
            nameInfo[@"name"] = obj.name;
        }];
        
        NSMutableString *caption = [NSMutableString string];
        
        NSInteger location = 0;
        while ([[captionString substringWithRange:NSMakeRange(location, 1)] isEqualToString:@"\n"] || [[captionString substringWithRange:NSMakeRange(location, 1)] isEqualToString:@" "]) {
            [caption appendString:[captionString substringWithRange:NSMakeRange(location, 1)]];
            location += 1;
            if (location >= captionString.length) {
                break;
            }
        }
        
        NSScanner *theScanner = [NSScanner scannerWithString:captionString];
        
        NSString *text = nil;
        NSMutableArray *links = [NSMutableArray array];
        
        BOOL hasLeftBrace = NO;
        while (nil != caption && ![theScanner isAtEnd]) {
            // find start of tag
            [theScanner scanUpToString:@"{" intoString:&text];
            
            [caption appendString:[text substringFromIndex:hasLeftBrace ? 1 : 0]];
            hasLeftBrace = YES;
            
            if ([theScanner isAtEnd]) {
                break;
            }
            
            [theScanner scanUpToString:@"}" intoString:&text];
            
            NSString *key = nil;
            NSString *name = nil;
            BOOL isAt = NO;
            BOOL isTopic = NO;

            if ([text hasPrefix:@"{@"]) {
                isAt = YES;
                key = [[text componentsSeparatedByString:@"@"] lastObject];
                name = nameInfo[key];
                if (nil != name) {
                    NSRange theRange = NSMakeRange(headLength + [caption length], [name length] + 1);
                    [links addObject:@{@"userId": key, @"range": NSStringFromRange(theRange)}];
                }
            } else if ([text hasPrefix:@"{@_s"]||[text hasPrefix:@"{@_t"]||[text hasPrefix:@"{@_r"]) {
                isAt = YES;
                key = [[text componentsSeparatedByString:@":"] lastObject];
                name = nameInfo[key];
            }else if ([text hasPrefix:@"{#"]) {
                isTopic = YES;
                key = [[text componentsSeparatedByString:@"#"] lastObject];
                name = nameInfo[key];
                if (nil != name) {
                    NSRange theRange = NSMakeRange(headLength + [caption length], [name length] + 2);
                    [links addObject:@{@"topicId": key, @"range": NSStringFromRange(theRange)}];
                }
            }

            
            if (nil != name) {
                if (isAt) {
                    [caption appendString:[NSString stringWithFormat:@"@%@ ", name]];
                }else if(isTopic){
                    [caption appendString:[NSString stringWithFormat:@"#%@#", name]];
                }
            } else {
                [caption appendString:text];
            }
        }
        
        self.caption = caption;
        self.links = links;
    }
}

- (void)transformAtWithContent:(NSString *)content atPersons:(NSArray *)atPersons isAtAll:(BOOL)isAtAll andHeadLength:(NSUInteger)headLength {
    [self transformAtWithContent:content atPersons:atPersons isAtAll:isAtAll topics:nil andHeadLength:headLength];
}

- (void)transformTopicWithContent:(NSString *)content topics:(NSArray *)topics andHeadLength:(NSUInteger)headLength{
    [self transformAtWithContent:content atPersons:nil isAtAll:NO topics:topics andHeadLength:headLength];
}

@end
