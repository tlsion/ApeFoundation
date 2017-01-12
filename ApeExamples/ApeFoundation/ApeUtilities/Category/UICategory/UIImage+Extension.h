//
//  UIImage+Extension.h
//  Youhu
//
//  Created by Eton on 2016/10/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface UIImage (Extension)

/**
 *  限制图片的最大分辨率和最大文件大小
 *
 *  @param fileSize 文件的大小，eg: 压缩图片到 100 KB，则为100*YWIMAGECOMPRESS_KB
 *  @param maxSide  最长边的分辨率
 *
 *  @return 压缩后的图片NSData
 */
-(NSData *)dataWithMaxFileSize:(CGFloat)fileSize maxSide:(CGFloat)maxSide;

//压缩图片, 0 最高压缩率，质量低,   1 基本不压缩
-(NSData *)dataWithCompressQuality:(CGFloat)compressionQuality;

//压缩图片到指定length, 单位: Byte
//eg: 压缩图片到 100 KB
// [imgObj dataWithCompressLength:100]
//降低质量，不改变分辨
-(NSData *)dataWithCompressLength:(CGFloat)length;

//降低分辨率，不改质量
-(NSData *)imageWithScaledToLength:(CGFloat)length;

//压缩图片到指定的 size
- (UIImage *)imageWithScaledToSize:(CGSize)newSize;

//图片等比拉伸至充满整个屏幕，一般是 把超大图 缩小成 屏幕一样大小时用。
-(UIImage *)imageBespreadFullScreen;

//view 转 image
+ (UIImage *)imageWithView:(UIView *)view;

//修正图片方向
- (UIImage *)fixOrientation;

/**
 *  保存图片到本地
 *
 *  @param fileName 保存为名字 包含后缀
 *
 *  @return 返回图片路径
 */
- (NSString *)saveImageToTempFoldreWithFileName:(NSString *)fileName;

//Color
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (void)imageFromPHAssets:(NSArray <PHAsset *> *)assets size:(CGSize )size resultHandler:(void (^ _Nullable )(NSArray *__nullable images))resultHandler;

+ (void)imageDataFromPHAssets:(NSArray <PHAsset *> *)assets resultHandler:(void (^ _Nullable )(NSArray *__nullable imageDatas))resultHandler;

+ (UIImage *__nullable)imageFromPHAsset:(PHAsset *__nullable)asset size:(CGSize )size;

+ (NSData *__nullable)imageDataFromPHAsset:(PHAsset *__nullable)asset;

@end
