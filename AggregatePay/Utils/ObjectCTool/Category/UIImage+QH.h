//
//  UIImage+QH.h
//  中汇支付
//
//  Created by cqh on 14/10/9.
//  Copyright (c) 2014年 Chepay. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIImage (QH)
/**
 *  对某个View进行截取,生成图片,图片的大小默认就是UIView的Size
 *
 *  @param view 指定UIView
 *
 *  @return 一张截图[快照]
 */
+ (UIImage* )captureWithView:(UIView *)view;

/**
 *  对某个View进行截取,生成一张指定Size截图
 *
 *  @param view    指定UIView
 *  @param newSize 一张截图[快照]
 *
 *  @return 一张指定size截图
 */
+ (UIImage*)imageWithView:(UIView *)view scaledToSize:(CGSize)newSize;

/**
 *  根据指定的尺寸和颜色,生成一张图片
 *
 *  @param size  花布的尺寸
 *  @param color 颜色
 *  @param alpha 透明度
 *
 *  @return 纯色的图片
 */
+ (UIImage *)imageWithSize:(CGSize)size PureColor:(UIColor *)color alpha:(CGFloat )alpha;

/**
 *  根据文件名生成一张,图片的位置在[NSBundel mainBundle]中,就是俗称的沙箱
 *
 *  @param name 沙箱中的图片名
 *
 *  @return 图片
 */

+ (UIImage *)imageWithFileName:(NSString *)name;

#pragma mark ***************************************************** 生成自由拉伸的图片主要是场景:UIImageView的size是由UIImage的size决定,如果改变UIImageView的大小,Image就会被放大/缩小得很难看,放大/缩小不是按照自己的想法来改变,所以需要一张按照自己想法拉伸/缩小的图片
/**
 *  生成一张从图片center拉伸的图片
 *
 *  @param imageName mages.xcassets中的图片名
 *
 *  @return 一张可以自由拉伸的图片
 */
+ (UIImage*)resizedImageWithName:(NSString*)imageName;

/**
 *  生成一张可以自由拉伸的图片
 *
 *  @param imageName Images.xcassets中的图片名
 *  @param left      拉伸位置的left[0-1]
 *  @param height    拉伸位置的right[0-1]
 *
 *  @return 一张可以自由拉伸的图片
 */
+ (UIImage*)resizedImageWithName:(NSString*)imageName left:(CGFloat) left height:(CGFloat)height;

/**
 *  生成一张质量[compressionQuality]低的图片
 *
 *  @param image 一张图片
 *
 *  @return 一张处理过的图片
 */
+ (UIImage *)handleImageWithImage:(UIImage *)image;

/**
 *  根据自定义中的.bundle中的图片名名生成一张图片
 *
 *  @param name      **.bundle中的bundle名
 *  @param imageName **.bundle中的图片名
 *
 *  @return 一张图片
 */
+ (UIImage *)imageWithBundleName:(NSString *)name imageName:(NSString *)imageName;


+ (UIImage *)cp_imageWithColor:(UIColor *)color;

/**
 *  生成一张圆形的纯色图片
 *
 *  @param color 颜色
 *  @param size  尺寸
 *  @param alpha 透明度
 *
 *  @return 一张圆形的图片
 */
+ (UIImage *)circleImageWithPureColor:(UIColor *)color size:(CGSize)size alpha:(CGFloat )alpha;

/**
 *  将一张UIImage scale 至 某个尺寸的UIImage
 *
 *  @param name    可拉升图片的图片名
 *  @param newSize 新尺寸
 *
 *  @return 加工之后的图片
 */
+ (UIImage *)resizedImageName:(NSString *)name scaledToSize:(CGSize)newSize;

//+ (UIImage *)renderingImageWithImage:(UIImage *)image color:(UIColor *)color;
@end

