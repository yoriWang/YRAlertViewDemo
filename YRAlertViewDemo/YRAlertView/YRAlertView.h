//
//  YRAlertView.h
//  YRAlertViewDemo
//
//  Created by 王煜仁 on 2017/8/26.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YRAlertHandler)(NSInteger idx, NSString *title);

@interface YRAlertView : UIView
/**
 选项回调
 */
@property (nonatomic, copy) YRAlertHandler alertHandler;
@property (nonatomic, strong) NSArray<NSString *> *imageArray;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
/**
 set item text color, default is black color.
 */
@property (nonatomic, strong) UIColor *itemTitleColor;
/**
 初始化方法
 
 @param title 标题
 @param message 文本
 @return self
 */
- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
/**
 初始化类方法
 
 @param title 标题
 @param message 文本
 @return self init
 */
+ (instancetype)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
/**
 设置弹出窗的菜单选项
 
 @param imageArray 图片数组
 @param titleArray 标题数组
 */
- (void)showAlertMenuWithImageArray:(nullable NSArray<NSString *> *)imageArray titleArray:(NSArray<NSString *> *)titleArray;
/**
 show current view.
 */
- (void)showAlertView;
/**
 remove current view from super view.
 */
- (void)dismissAlertView;
@end

NS_ASSUME_NONNULL_END
