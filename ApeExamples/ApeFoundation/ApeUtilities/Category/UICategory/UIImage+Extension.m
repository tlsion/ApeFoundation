//
//  UIImage+Extension.m
//  Youhu
//
//  Created by Eton on 2016/10/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "UIImage+Extension.h"
#import "UIImage+GIF.h"

@implementation UIImage (Extension)

//压缩图片, 0 最高压缩率，质量低,   1 基本不压缩
-(NSData *)dataWithCompressQuality:(CGFloat)compressionQuality
{
    NSData *imgData = UIImageJPEGRepresentation(self, compressionQuality);
    return imgData;
}

//压缩图片到指定length


//降低质量，不改变分辨
-(NSData *)dataWithCompressLength:(CGFloat)length
{
    length = length * 1024;
    CGFloat quality = 1;
    NSData * imgData = UIImageJPEGRepresentation(self, quality);
    while (imgData.length > length) {
        quality -= 0.1;
        imgData = UIImageJPEGRepresentation(self,quality);
        if (quality <0.2)
            break;
    };
    return imgData;
}

//限制图片的最大分辨率和最大文件大小
-(NSData *)dataWithMaxFileSize:(CGFloat)fileSize maxSide:(CGFloat)maxSide{
    CGFloat quality = 1;
    NSData * imgData = [self limitImageToMaxSize:maxSide];
    
    while (imgData.length > fileSize) {
        quality -= 0.1;
        imgData = UIImageJPEGRepresentation(self,quality);
        if (quality <0.2)
            break;
    };
    return imgData;
}


- (NSData *)limitImageToMaxSize:(CGFloat)maxSide {
    NSData * imgData = UIImageJPEGRepresentation(self, 0.8);
    
    CGFloat original_width  = self.size.width;
    CGFloat original_height = self.size.height;
    if(original_width>maxSide || original_height>maxSide){
        CGFloat scale = original_width>original_height?(maxSide/original_width):(maxSide/original_height);
        CGSize newSize = CGSizeMake(original_width*scale, round(original_height * scale));
        CGRect scaleRect =  CGRectMake(0, 0, newSize.width, newSize.height );
        UIGraphicsBeginImageContext(CGSizeMake(original_width*scale, original_height*scale));
        [self drawInRect:scaleRect];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        imgData = UIImageJPEGRepresentation(newImage, 0.8);
        UIGraphicsEndImageContext();
        
    }
    return imgData;
}

//降低分辨率，不改变质量
- (NSData *)imageWithScaledToLength:(CGFloat)length{
    NSData * imgData = UIImageJPEGRepresentation(self, 0.8);
    CGFloat scale = 1.0;
    CGFloat stepping = 0.2;//步进缩小0.2
    while (imgData.length > length) {
        if(scale > stepping*2){
            scale -= stepping;
        }else{
            break;
        }
        //NSLog(@"imageWithScaledToLength,scale: %f",scale);
        CGFloat original_width  = self.size.width;
        CGFloat original_height = self.size.height;
        CGSize newSize = CGSizeMake(original_width*scale, round(original_height * scale));
        CGRect scaleRect =  CGRectMake(0, 0, newSize.width, newSize.height );
        UIGraphicsBeginImageContext(CGSizeMake(original_width*scale, original_height*scale));
        [self drawInRect:scaleRect];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        imgData = UIImageJPEGRepresentation(newImage, 0.8);
        UIGraphicsEndImageContext();
    };
    return imgData;
}

- (UIImage *)imageWithScaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage *)imageBespreadFullScreen
{
    UIImage * ret = nil;
    UIScreen * screen = [UIScreen mainScreen];
    float imageWidth = self.size.width;
    float imageHeight = self.size.height;
    float width = 0;
    float height = 0;
    if (imageWidth < imageHeight)
    {
        //竖长图
        width = screen.applicationFrame.size.width * screen.scale;
        height = imageHeight/(imageWidth/width);
    }else
    {
        //横长图
        height = screen.applicationFrame.size.height * screen.scale;
        width = imageWidth/(imageHeight/height);
    }
    width = 640;
    height = 640;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, width , height)];
    // 从当前context中创建一个改变大小后的图片
    ret = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return ret;
}


//view 转 image
+ (UIImage *)imageWithView:(UIView *)view
{
    
    float scale = [[UIScreen mainScreen] scale];
    //    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)), NO, scale);
    //    [view drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)) afterScreenUpdates:NO];
    //    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return snapshot;
    
    /*因以上方法，无法截取超大的view，因此用以下方法替换*/
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)), NO, 0);
    
    //设置截屏大小
    
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, view.bounds.size.width * scale, view.bounds.size.height * scale);//这里可以设置想要截图的区域
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *snapshot = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    //    snapshot = [self imageWithImageSimple:snapshot scaledToSize:CGSizeMake(view.bounds.size.width, view.bounds.size.height)];
    
    return snapshot;
}

- (NSString *)saveImageToTempFoldreWithFileName:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    // Save image.
    NSData *imageData = [self compressionWithMaxKByte:5000.0f];
//    NSLog(@"imgScarle:%lu",(unsigned long)imageData.length);
    
    [imageData writeToFile:filePath atomically:YES];
    return filePath;
}

//图片如超过最大字节 按比率压缩
-(NSData * )compressionWithMaxKByte:(CGFloat )maxKByte{
    if (maxKByte<=0) {
        return UIImageJPEGRepresentation(self, 0.8f);
    }
    
    NSData * aImageData=UIImageJPEGRepresentation(self, 1.0f);
    
    //算出比例差值
    CGFloat maxByte = maxKByte * 1024;
    
    CGFloat multiple = MIN(aImageData.length/maxByte, 10.0) ;
    
    CGFloat compressionQuality = 1 - multiple/10;
    
    if (aImageData.length>maxByte) {
        aImageData=UIImageJPEGRepresentation(self, compressionQuality);
    }
    
    NSLog(@"alength:%lu",(unsigned long)aImageData.length);
    
    return aImageData;
    //    return aImageData;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}


+ (void)imageFromPHAssets:(NSArray <PHAsset *> *)assets size:(CGSize )size resultHandler:(void (^ _Nullable )(NSArray *__nullable images))resultHandler
{
    __block NSInteger count = assets.count;
    NSMutableArray * resultImages = [NSMutableArray array];
    for (PHAsset * asset in assets) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        // 是否要原图
        if (size.width == 0 || size.height == 0) {
            size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        }else if (asset.pixelWidth < size.width || asset.pixelHeight < size.height){
            size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
        }
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            count--;
            [resultImages addObject:result];
            if (count == 0) {
                resultHandler(resultImages);
            }
        }];
    }
}

+ (void)imageDataFromPHAssets:(NSArray <PHAsset *> *)assets resultHandler:(void (^ _Nullable )(NSArray *__nullable imageDatas))resultHandler
{
    __block NSInteger count = assets.count;
    NSMutableArray * resultImages = [NSMutableArray array];
    for (PHAsset * asset in assets) {
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
            
            size_t imageCount = CGImageSourceGetCount(source);
            
            UIImage *animatedImage;
            
            if (imageCount <= 1) {
                animatedImage = [[UIImage alloc] initWithData:imageData];
            }else{
                animatedImage = [UIImage sd_animatedGIFWithData:imageData];
            }
            
            count--;
            [resultImages addObject:animatedImage];
            if (count == 0) {
                resultHandler(resultImages);
            }
            
        }];
    }
}

+ (UIImage *__nullable)imageFromPHAsset:(PHAsset *__nullable)asset size:(CGSize )size
{
    __block UIImage * resultImage = nil;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 是否要原图
    if (size.width == 0 || size.height == 0) {
        size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    }else if (asset.pixelWidth < size.width || asset.pixelHeight < size.height){
        size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    }
    
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        resultImage = result;
    }];
    return resultImage;
}

+ (NSData *__nullable)imageDataFromPHAsset:(PHAsset *__nullable)asset
{
    __block NSData * resultData = nil;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        resultData = imageData;
    }];
    return resultData;
}


- (UIImage *)fixOrientation {
    UIImage * aImage = self;
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
