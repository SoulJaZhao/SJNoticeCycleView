//
//  SJNoticeCycleView.h
//  Pods
//
//  Created by SoulJa on 2017/8/14.
//
//

#import <UIKit/UIKit.h>

@class SJNoticeCycleView;
@protocol SJNoticeCycleViewDelegate <NSObject>
@optional
/**
 *  点击通知的回调
 *  @param  cycleView   MPOSNoticeCycleView
 *  @param  index       点击的索引
 */
- (void)noticeCycleView:(SJNoticeCycleView *)cycleView didSelectNoticeAtIndex:(NSInteger)index;

@end

@interface SJNoticeCycleView : UIView

/** 标题图片 **/
@property (nonatomic, strong) UIImage *titleImage;

/** 通知列表 **/
@property (nonatomic, strong) NSArray *noticeList;

/** 循环时间 **/
@property (nonatomic, assign) CGFloat cycleTime;

/** 代理 **/
@property (nonatomic, weak) id<SJNoticeCycleViewDelegate> delegate;

/**
 *  初始化方法
 *  @param  frame           尺寸
 *  @param  titleImage      标题图片
 *  @param  noticeList      消息数组
 */
- (instancetype)initWithFrame:(CGRect)frame TitleImage:(UIImage *)titleImage NoticeList:(NSArray *)noticeList;
@end
