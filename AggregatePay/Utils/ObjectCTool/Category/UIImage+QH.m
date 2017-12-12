//
//  UIImage+QH.m
//  中汇支付
//
//  Created by cqh on 14/10/9.
//  Copyright (c) 2014年 Chepay. All rights reserved.
//

#import "UIImage+QH.h"

@implementation UIImage (QH)
/**
 *  将一张UIImage scale 至 某个尺寸的UIImage
 *
 *  @param name    可拉升图片的图片名
 *  @param newSize 新尺寸
 *
 *  @return 加工之后的图片
 */
+ (UIImage *)resizedImageName:(NSString *)name scaledToSize:(CGSize)newSize{
    
    UIImage *image = [UIImage imageNamed:name];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, newSize.width, newSize.height);
    return [UIImage captureWithView:imageView];
}

/**
 *  给指定的view截图
 *
 *  @param view 指定的View
 *
 *  @return 一张截图
 */
+ (UIImage* )captureWithView:(UIView *)view
{
    return [UIImage imageWithView:view scaledToSize:view.frame.size];
}

/**
 *  给指定的view截图
 *
 *  @param view 指定的View
 *  @param newSize 新的尺寸
 *  @return 一张截图
 */

+ (UIImage *)imageWithView:(UIView *)view scaledToSize:(CGSize)newSize
{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    //将当前的view的图层呈现在当前上下文，获取某个图层的图片 view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 3.取出图片
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 4.结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  根据制定的颜色绘制一张图片
 *  @param: size  图片的尺寸
 *  @param: color  图片的颜色
 *  @param: alpha  图片的alpha
 */
+ (UIImage *)imageWithSize:(CGSize)size PureColor:(UIColor *)color alpha:(CGFloat )alpha{
    UIGraphicsBeginImageContextWithOptions(size, 0, 0.0);
    [[color colorWithAlphaComponent:alpha] set];
    UIRectFill((CGRect){{0,0},size});
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsZero];
    
}

+ (UIImage *)cp_imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIEdgeInsets insets = UIEdgeInsetsMake(1, 1, 1, 1);
    return [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

/**
 *  根据制定的颜色绘制一张图片
 *  @param: size  图片的尺寸
 *  @param: color  图片的颜色
 *  @param: alpha  图片的alpha
 */
+ (UIImage *)circleImageWithPureColor:(UIColor *)color size:(CGSize)size alpha:(CGFloat )alpha{
    
    UIGraphicsBeginImageContextWithOptions(size, 0, 0.0);
    [[color colorWithAlphaComponent:alpha] set];
    [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)] fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithFileName:(NSString *)name {
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:name ofType:@"png"];
    return [UIImage imageWithContentsOfFile:imagePath];
    
}

// 因为你让backgroundImage根据文字的font进行拉伸....可能不会好看....  返回一张可以自由拉伸的图片......
+ (UIImage*)resizedImageWithName:(NSString*)imageName{
    
    return [self resizedImageWithName:imageName left:.5f height:.5f];;
}

+ (UIImage *)resizedImageWithName:(NSString *)imageName left:(CGFloat)left height:(CGFloat)height
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:left*image.size.width topCapHeight:height*image.size.height];
}

+ (UIImage *) handleImageWithImage:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 0.0001);//
    return [[UIImage alloc] initWithData:data];
}


+ (UIImage *) imageWithBundleName:(NSString *)name imageName:(NSString *)imageName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"bundle"
     ];
    filePath = [filePath stringByAppendingPathComponent:imageName];
    return [UIImage imageWithContentsOfFile:filePath];
}


//+ (UIImage *)renderingImageWithImage:(UIImage *)image color:(UIColor *)color
//{
//     [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    
//}
@end
