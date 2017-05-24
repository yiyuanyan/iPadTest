//
//  UIColor+XCAdditions.h
//  GoGoTalk
//
//  Created by XieHenry on 2017/4/26.
//  Copyright © 2017年 XieHenry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XCAdditions)

+ (UIColor *)colorWithHexString:(NSString *)hexColorString;

+ (UIColor *)colorWithHexString:(NSString *)hexColorString alphaString:(NSString *)alphaString;

+ (UIColor *)colorWithHex:(NSInteger)hexValue;

+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
