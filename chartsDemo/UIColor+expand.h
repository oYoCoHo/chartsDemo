//
//  UIColor+expand.h
//  motan_new
//
//  Created by ve2 on 17/3/22.
//  Copyright © 2017年 ve2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (expand)

#pragma mark - 十六进制
// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor *)colorWithHex:(long)hexColor;
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(float)opacity;

#pragma mark - RGB
+(UIColor*)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;
+(UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;


#pragma mark -
///** 如果不想在主题变化时，界面颜色自动重新渲染，可以用这个方法获取当前主题下特定的颜色 */
//+ (UIColor *)colorKey:(NSString *)key;
@end
