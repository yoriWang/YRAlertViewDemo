//
//  YRAlertView.m
//  YRAlertViewDemo
//
//  Created by 王煜仁 on 2017/8/26.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "YRAlertView.h"

#define kAlertBtnW 50
#define kAlertBtnH 40

@interface YRAlertView () {
    NSInteger _minCount;//根据最小数组设置弹窗
    CGFloat _maxWidth;//设置视图的最大宽度
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *messageLabel;
@property (nonatomic, weak) UIView *alertView;
@property (nonatomic, weak) UIButton *coverBtn;
@end

@implementation YRAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message {
    self = [super init];
    if (self) {
        
        [self setupBackgroundShadow];
        
        self.title = title;
        self.message = message;
        //default color
        self.itemTitleColor = [UIColor blackColor];
        
        [self setupTitleAndMessageControl];
        
    }
    
    return self;
    
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message {
    
    return [[self alloc] initWithTitle:title message:message];
    
}

#pragma mark - 设置遮罩
- (void)setupBackgroundShadow {
    
    //遮罩层
    UIButton *coverBtn = [[UIButton alloc] init];
    coverBtn.backgroundColor = [UIColor colorWithWhite:0.01 alpha:0.3f];
    [coverBtn addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:coverBtn];
    self.coverBtn = coverBtn;
    
    //设置item视图
    UIView *alertView = [[UIView alloc] init];
    alertView.backgroundColor = [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0f];
    [self addSubview:alertView];
    self.alertView = alertView;
    
}

#pragma mark - 设置标题和消息控件
- (void)setupTitleAndMessageControl {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = self.title;
    [self.alertView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:16.f];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.text = self.message;
    [self.alertView addSubview:messageLabel];
    self.messageLabel = messageLabel;
    
}

#pragma mark - setter/getter
- (void)setImageArray:(NSArray<NSString *> *)imageArray {
    _imageArray = imageArray;
}

-(void)setTitleArray:(NSArray<NSString *> *)titleArray {
    _titleArray = titleArray;
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor {
    
    _itemTitleColor = itemTitleColor;
    
    [self layoutIfNeeded];
    
}

#pragma mark - 设置选项菜单
- (void)showAlertMenuWithImageArray:(NSArray<NSString *> *)imageArray titleArray:(NSArray<NSString *> *)titleArray {
    
    _minCount = titleArray.count;
    
    if (imageArray) {
        if (imageArray.count != titleArray.count) {
            _minCount = imageArray.count > titleArray.count ? titleArray.count : imageArray.count;
        }
    }
    
    //设置选项按钮
    for (int i = 0; i < _minCount; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.adjustsImageWhenHighlighted = NO;
        button.titleLabel.font = [UIFont systemFontOfSize:16.f];
        button.tag = i;
        if (imageArray) {
            [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        }
        [button setBackgroundImage:[UIImage imageNamed:@"item_normal_img"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"item_selected_img"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClickAlertItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:button];
    }
    
}

#pragma mark - 点击事件
- (void)didClickAlertItem:(UIButton *)button {
    
    self.alertHandler(button.tag, button.currentTitle);
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.coverBtn.frame = self.bounds;
    
    if (self.alertView.subviews.count > 2) {
        for (int i = 0; i < self.alertView.subviews.count; i++) {
            UIView *subView = self.alertView.subviews[i];
            
            if ([subView isKindOfClass:[UIButton class]]) {
                
                UIButton *itemBtn = (UIButton *)subView;
                
                [itemBtn setTitleColor:self.itemTitleColor forState:UIControlStateNormal];
                
            }
            
        }
    }
    
}

#pragma mark - 显示并设置控件的frame
- (void)showAlertView {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    
    CGFloat width = window.bounds.size.width * 2 / 3;
    _maxWidth = width;
    
    CGSize titleSize = [self boundsWithText:self.title font:self.titleLabel.font];
    self.titleLabel.frame = CGRectMake(0, 0, width, titleSize.height);
    
    CGSize messageSize = [self boundsWithText:self.message font:self.messageLabel.font];
    self.messageLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), width, messageSize.height + 10);
    
    CGFloat height = CGRectGetMaxY(self.messageLabel.frame) + _minCount * kAlertBtnH;
    
    self.alertView.frame = CGRectMake(width / 4, (window.bounds.size.height - height) / 2, width, height);
    NSInteger count = 0;
    for (int i = 0; i < self.alertView.subviews.count; i++) {
        UIView *subView = self.alertView.subviews[i];
        
        if ([subView isKindOfClass:[UIButton class]]) {
            subView.frame = CGRectMake(0, CGRectGetMaxY(self.messageLabel.frame) + kAlertBtnH * count, width, kAlertBtnH);
            count++;
        }
        
    }
    
    [window addSubview:self];
    
}

#pragma mark - 点击菜单以外的部分
- (void)coverClick:(UIButton *)button {
    
    [self dismissAlertView];
    
}

- (void)dismissAlertView {
    [self removeFromSuperview];
}

#pragma mark - 文本宽高计算-私有方法
- (CGSize)boundsWithText:(NSString *)text font:(UIFont *)font{
    
    return [text boundingRectWithSize:CGSizeMake(_maxWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
}

@end
