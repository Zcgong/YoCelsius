//
//  MaxTempView.m
//  YXMWeather
//
//  Created by XianMingYou on 15/2/20.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "MaxTempView.h"
#import "GridView.h"
#import "MaxTempCountLabel.h"
#import "MinTempContLabel.h"

@interface CenterLineViewStoreValue : NSObject
@property (nonatomic) CGRect startRect;
@property (nonatomic) CGRect midRect;
@property (nonatomic) CGRect endRect;
@end
@implementation CenterLineViewStoreValue
@end

@interface MaxTempView ()

@property (nonatomic, strong) GridView  *gridView;

@property (nonatomic, strong) UIView                    *centerLineView;
@property (nonatomic, strong) CenterLineViewStoreValue  *centerLineViewStoreValue;

@property (nonatomic, strong) UIView                    *minTempView;
@property (nonatomic, strong) CenterLineViewStoreValue  *minTempViewStoreValue;

@property (nonatomic, strong) UIView                    *maxTempView;
@property (nonatomic, strong) CenterLineViewStoreValue  *maxTempViewStoreValue;

@property (nonatomic, strong) UIView                    *maxCountView;
@property (nonatomic, strong) CenterLineViewStoreValue  *maxCountViewStoreValue;

@property (nonatomic, strong) UIView                    *minCountView;
@property (nonatomic, strong) CenterLineViewStoreValue  *minCountViewStoreValue;


@property (nonatomic, strong) MaxTempCountLabel         *maxTempCountLabel;
@property (nonatomic, strong) MinTempContLabel          *minTempCountLabel;


@property (nonatomic, strong) UILabel                   *titleLabel;
@property (nonatomic, strong) CenterLineViewStoreValue  *titleLabelStoreValue;


@end

@implementation MaxTempView

- (void)buildView {
    
    // 创建出格子view
    self.gridView  = [[GridView alloc] initWithFrame:CGRectZero];
    self.gridView.origin     = CGPointMake(0, 0);
    self.gridView.gridLength = 20.f;
    [self.gridView buildView];
    [self addSubview:self.gridView];
    
    // 中间的横条view
    self.centerLineViewStoreValue = [CenterLineViewStoreValue new];
    self.centerLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _gridView.gridLength * 2, _gridView.gridLength * 5, 1.f)];
    self.centerLineView.backgroundColor = [UIColor blackColor];
    self.centerLineViewStoreValue.midRect = self.centerLineView.frame;
    self.centerLineView.width = 0.f;
    self.centerLineViewStoreValue.startRect = self.centerLineView.frame;
    self.centerLineView.x = _gridView.gridLength * 5;
    self.centerLineViewStoreValue.endRect = self.centerLineView.frame;
    self.centerLineView.alpha = 0.f;
    self.centerLineView.frame = self.centerLineViewStoreValue.startRect;
    
    // 最小温度
    self.minTempViewStoreValue = [CenterLineViewStoreValue new];
    self.minTempView = [[UIView alloc] initWithFrame:CGRectMake(_gridView.gridLength * 1, _gridView.gridLength * 2, _gridView.gridLength * 1, 0)];
    self.minTempView.backgroundColor = [UIColor blackColor];
    self.minTempView.alpha = 0.f;
    self.minTempViewStoreValue.startRect = self.minTempView.frame;
    [self addSubview:self.minTempView];
    
    // 最低温度显示
    self.minCountView = [[UIView alloc] initWithFrame:CGRectMake(_gridView.gridLength * 1, _gridView.gridLength * 2, _gridView.gridLength * 1, _gridView.gridLength)];
    [self addSubview:self.minCountView];
    self.minCountViewStoreValue = [CenterLineViewStoreValue new];
    self.minCountViewStoreValue.startRect = self.minCountView.frame;
    self.minCountView.alpha = 0.f;

    
    // 最大温度
    self.maxTempViewStoreValue = [CenterLineViewStoreValue new];
    self.maxTempView = [[UIView alloc] initWithFrame:CGRectMake(_gridView.gridLength * 3, _gridView.gridLength * 2, _gridView.gridLength * 1, 0)];
    self.maxTempView.backgroundColor = [UIColor blackColor];
    self.maxTempViewStoreValue.startRect = self.maxTempView.frame;
    self.maxTempView.alpha = 0.f;
    
    // 最大温度显示
    self.maxCountView = [[UIView alloc] initWithFrame:CGRectMake(_gridView.gridLength * 3, _gridView.gridLength * 2, _gridView.gridLength * 1, _gridView.gridLength)];
    [self addSubview:self.minCountView];
    self.maxCountViewStoreValue = [CenterLineViewStoreValue new];
    self.maxCountViewStoreValue.startRect = self.maxCountView.frame;
    [self addSubview:self.maxCountView];
    self.maxCountView.alpha = 0.f;
    
    // 最大温度动态显示
    self.maxTempCountLabel = [[MaxTempCountLabel alloc] initWithFrame:CGRectMake(0, 0, 60, _gridView.gridLength)];
    [self.maxCountView addSubview:self.maxTempCountLabel];

    // 最小温度动态显示
    self.minTempCountLabel = [[MinTempContLabel alloc] initWithFrame:CGRectMake(0, 0, 60, _gridView.gridLength)];
    [self.minCountView addSubview:self.minTempCountLabel];
    
    [self addSubview:self.maxTempView];
    [self addSubview:self.centerLineView];
    
    // 标题
    self.titleLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.titleLabel.text          = @"Temperature";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font          = [UIFont fontWithName:LATO_BOLD size:LATO_14];
    self.titleLabel.width         = 100;
    self.titleLabel.height        = 20.f;
    self.titleLabel.x            -= 3.f;
    self.titleLabel.y             = self.gridView.height - 15;
    self.titleLabel.alpha = 0.f;
    [self addSubview:self.titleLabel];
    self.titleLabelStoreValue     = [CenterLineViewStoreValue new];
    self.titleLabelStoreValue.midRect = self.titleLabel.frame;
    self.titleLabel.x            += 10;
    self.titleLabelStoreValue.startRect = self.titleLabel.frame;
    self.titleLabel.x            -= 20;
    self.titleLabelStoreValue.endRect  = self.titleLabel.frame;
    self.titleLabel.frame = self.titleLabelStoreValue.startRect;
}

- (void)show {
    CGFloat duration = 1.75;
    
    // 格子动画效果
    [self.gridView showWithDuration:1.5f];
    
    if (self.minTemp >= 0) {
        self.minCountView.y -= self.gridView.gridLength;
    }
    
    if (self.maxTemp >= 0) {
        self.maxCountView.y -= self.gridView.gridLength;
    }
    
    self.maxTempCountLabel.toValue = self.maxTemp;
    [self.maxTempCountLabel showDuration:duration];
    
    self.minTempCountLabel.toValue = self.minTemp;
    [self.minTempCountLabel showDuration:duration];
    
    // 中间线条动画效果
    [UIView animateWithDuration:0.75 delay:0.35 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.centerLineView.frame = self.centerLineViewStoreValue.midRect;
        self.centerLineView.alpha = 1.f;
        
        
        NSLog(@"%f", self.minTemp);
        NSLog(@"%f", self.maxTemp);
        
        
        self.minTempView.height = self.minTemp;
        self.minTempView.y     -= self.minTemp;
        self.minTempView.alpha  = 1.f;
        self.minCountView.y    -= self.minTemp;
        self.minCountView.alpha = 1.f;


        
        self.maxTempView.height = self.maxTemp;
        self.maxTempView.y     -= self.maxTemp;
        self.maxTempView.alpha  = 1.f;
        self.maxCountView.y    -= self.maxTemp;
        self.maxCountView.alpha = 1.f;
        
        self.titleLabel.frame = self.titleLabelStoreValue.midRect;
        self.titleLabel.alpha = 1.f;

    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    CGFloat duration = 0.75f;
    
    // 格子动画效果
    [self.gridView hideWithDuration:duration];
    
    [UIView animateWithDuration:duration animations:^{
        self.centerLineView.alpha = 0.f;
        
        self.minTempView.frame = self.minTempViewStoreValue.startRect;
        self.minTempView.alpha = 0.f;
        
        self.maxTempView.frame = self.maxTempViewStoreValue.startRect;
        self.maxTempView.alpha = 0.f;
        
        self.minCountView.alpha   = 0.f;
        self.minCountView.x      += 10.f;
        self.maxCountView.alpha   = 0.f;
        self.maxCountView.x      += 10.f;
        
        
        self.titleLabel.frame = self.titleLabelStoreValue.endRect;
        self.titleLabel.alpha = 0.f;

    } completion:^(BOOL finished) {
        self.centerLineView.frame = self.centerLineViewStoreValue.startRect;
        self.minCountView.frame   = self.minCountViewStoreValue.startRect;
        self.maxCountView.frame   = self.maxCountViewStoreValue.startRect;
        
        self.titleLabel.frame = self.titleLabelStoreValue.startRect;
    }];
}

@end
