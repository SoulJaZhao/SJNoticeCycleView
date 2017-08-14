//
//  SJNoticeCycleViewCell.h
//  Pods
//
//  Created by SoulJa on 2017/8/14.
//
//

#import <UIKit/UIKit.h>

@interface SJNoticeCycleViewCell : UITableViewCell
/** 左端视图 **/
@property (nonatomic, strong) UIImageView *iconImageView;
/** 右端Label **/
@property (nonatomic, strong) UILabel *titleLabel;
/** 通知 **/
@property (nonatomic, strong) NSString *notice;
@end
