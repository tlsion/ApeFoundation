//
//  ApeTablePlaceHolderView.h
//  TinyShop
//
//  Created by tingxie on 16/4/13.
//  Copyright © 2016年 zhenwanxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ApeTablePlaceHolderType) {
    
    ApeTablePlaceHolderTypeUndefined = 0,
    
    ApeTablePlaceHolderTypeServerError, //服务器出错
    ApeTablePlaceHolderTypeNetworkFail, //网络请求失败
    ApeTablePlaceHolderTypeDataNull //暂无数据
};

typedef void(^ReloadButtonClickBlock)() ;

@interface ApeTablePlaceHolderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *o_imageView;
@property (weak, nonatomic) IBOutlet UILabel *o_textLabel;
@property (weak, nonatomic) IBOutlet UILabel *o_descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *o_clickButton;
@property (nonatomic, copy) ReloadButtonClickBlock o_reloadButtonClickBlock;
@property (nonatomic, assign) ApeTablePlaceHolderType o_placeHolderType; //Default: ApeTablePlaceHolderTypeUndefined

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *o_clickButtonWidthConstraints;

+ (instancetype)placeHolderViewWithImage:(UIImage *)aImage text:(NSString *)aText description:(NSString *)aDescription clickText:(NSString *)clickText reloadBlock:(ReloadButtonClickBlock)reloadBlock;

+ (instancetype)placeHolderViewWithPlaceHolderType:(ApeTablePlaceHolderType )aPlaceHolderType reloadBlock:(ReloadButtonClickBlock )reloadBlock;

@end
