//
//  Defines.h
//  YYAtPersonDemo
//
//  Created by Ace on 2017/9/11.
//  Copyright © 2017年 Ace. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#endif /* Defines_h */

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

typedef void (^YYBlock)(id userInfo);
typedef BOOL (^YYBOOLBlock) (id userInfo);

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define UIColorFromRGB(rgbValue)                                                                   \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                           \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                              \
                     blue:((float)(rgbValue & 0xFF)) / 255.0                                       \
                    alpha:1.0]

#define UIColorFromRGBA(rgbValue,a)                                                                \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                           \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                              \
                     blue:((float)(rgbValue & 0xFF)) / 255.0                                       \
                    alpha:a]
