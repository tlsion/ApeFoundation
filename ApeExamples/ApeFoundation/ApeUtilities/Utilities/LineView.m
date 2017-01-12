//
//  TXLineView.m
//  TinyShop
//
//  Created by tingxie on 15/10/13.
//  Copyright © 2015年 zhenwanxiang. All rights reserved.
//

#import "LineView.h"

@interface LineView ()

@property (nonatomic,strong) UIView * lineView;


@end


@implementation LineView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self ) {

        [self initLineView];
        self.o_lineColor = RGBS(229);
    }
    return self;
}

- (void)awakeFromNib{

    [super awakeFromNib];
    
    self.o_lineColor = [self backgroundColor];
    
}
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
     // Drawing code
     [self initLineView];
 }

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutLineView];
}


-(void) initLineView
{
    if (_lineView) {
        return;
    }
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = self.o_lineColor;
    [self addSubview:_lineView];
    self.backgroundColor = [UIColor clearColor];
    
}


-(void) layoutLineView
{
    //竖线 （居中）
    if (self.frame.size.width == 1.0f) {
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.height.equalTo(self.mas_height);
            make.width.equalTo(@(0.5));
        }];
    }
    
    //横线 区分 顶部和底部
    if (self.frame.size.height == 1.0f) {

        //判断是否是底部
        BOOL isBottom = NO;
        CGFloat interval = self.superview.frame.size.height - (self.frame.origin.y + self.frame.size.height);
        //在cell上计算会有误差，所以需用 0-1 的区间来判断
        if (interval >= 0 && interval <= 1) {//autolayer情况
            isBottom = YES;
        }
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top).offset(isBottom?0.5:0);
            make.width.equalTo(self.mas_width);
            make.height.equalTo(@(0.5));
        }];
    }
}


-(void) setO_lineColor:(UIColor *)o_lineColor
{
    _o_lineColor = o_lineColor;
    _lineView.backgroundColor = o_lineColor;
}

@end
