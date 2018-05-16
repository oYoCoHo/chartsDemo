//
//  UIColor+expand.m
//  motan_new
//
//  Created by ve2 on 17/3/22.
//  Copyright © 2017年 ve2. All rights reserved.
//

#import "UIColor+expand.h"
//#import "ThemeManager.h"
@implementation UIColor (expand)
// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor*) colorWithHex:(long)hexColor;
{
    return [UIColor colorWithHex:hexColor alpha:1.];
}
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    return [self colorWithHexString:color alpha:1.0];
}

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(float)opacity
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:opacity];
}

+(UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

+(UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];

}
///** 如果不想在主题变化时，界面颜色自动重新渲染，可以用这个方法获取当前主题下特定的颜色 */
//+ (UIColor *)colorKey:(NSString *)key
//{
//    return [[ThemeManager sharedManager] colorForKey:key];
//}
@end
