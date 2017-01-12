//
//  ApeTablePlaceHolderView.m
//  TinyShop
//
//  Created by tingxie on 16/4/13.
//  Copyright © 2016年 zhenwanxiang. All rights reserved.
//

#import "ApeTablePlaceHolderView.h"

@implementation ApeTablePlaceHolderView

+ (instancetype)placeHolderViewWithImage:(UIImage *)aImage text:(NSString *)aText description:(NSString *)aDescription clickText:(NSString *)clickText reloadBlock:(ReloadButtonClickBlock)reloadBlock{
    ApeTablePlaceHolderView * placeHolderView = [ApeTablePlaceHolderView loadFromNIB];
    placeHolderView.o_imageView.image = aImage;
    placeHolderView.o_textLabel.text = aText;
    placeHolderView.o_descriptionLabel.text = aDescription;
    [placeHolderView.o_clickButton setTitle:clickText forState:UIControlStateNormal];
    placeHolderView.o_clickButtonWidthConstraints.constant = [clickText estimateTextWidthByTextFont:placeHolderView.o_clickButton.titleLabel.font] + 60;
    placeHolderView.o_reloadButtonClickBlock = reloadBlock;
    placeHolderView.o_placeHolderType = ApeTablePlaceHolderTypeUndefined;
    
    return placeHolderView;
}

+ (instancetype)placeHolderViewWithPlaceHolderType:(ApeTablePlaceHolderType )aPlaceHolderType reloadBlock:(ReloadButtonClickBlock )reloadBlock{
    ApeTablePlaceHolderView * placeHolderView = [ApeTablePlaceHolderView loadFromNIB];
    placeHolderView.o_placeHolderType = aPlaceHolderType;
    placeHolderView.o_reloadButtonClickBlock = reloadBlock;
    placeHolderView.o_placeHolderType = ApeTablePlaceHolderTypeUndefined;
    return placeHolderView;
}

- (void)setO_placeHolderType:(ApeTablePlaceHolderType)o_placeHolderType{
    _o_placeHolderType = o_placeHolderType;
    switch (o_placeHolderType) {
        case ApeTablePlaceHolderTypeServerError:
        {
            self.o_imageView.image = [UIImage imageNamed:@"null_null"];
            self.o_textLabel.text = @"找不到服务器";
            self.o_descriptionLabel.text = @"人世间最远距离就是没网";
            self.o_clickButton.hidden = YES;
            break;
        }
        case ApeTablePlaceHolderTypeNetworkFail:
        {
            self.o_imageView.image = [UIImage imageNamed:@"null_null"];
            self.o_textLabel.text = @"网络请求失败";
            self.o_descriptionLabel.text = @"人世间最远距离就是没网";
            self.o_clickButton.hidden = YES;
            break;
        }
        case ApeTablePlaceHolderTypeDataNull:
        {
            self.o_imageView.image = [UIImage imageNamed:@"null_null"];
            self.o_textLabel.text = @"暂无数据";
            self.o_descriptionLabel.text = nil;
            self.o_clickButton.hidden = YES;
            break;
        }
        default:
        {
            self.o_imageView.image = [UIImage imageNamed:@"null_null"];
            self.o_textLabel.text = @"暂无数据";
            self.o_descriptionLabel.text = nil;
            self.o_clickButton.hidden = YES;
            break;
        }
            break;
    }

}

- (void)setO_reloadButtonClickBlock:(ReloadButtonClickBlock)o_reloadButtonClickBlock{
    _o_reloadButtonClickBlock = o_reloadButtonClickBlock;
    self.o_clickButton.hidden = !(o_reloadButtonClickBlock);
    if (o_reloadButtonClickBlock) {
        [self.o_clickButton addTarget:self action:@selector(reloadButtonClicked) forControlEvents:UIControlEventTouchUpInside] ;
    }
}

- (void)reloadButtonClicked {
    if (self.o_reloadButtonClickBlock) {
        self.o_reloadButtonClickBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
