//
//  SJNoticeCycleViewCell.m
//  Pods
//
//  Created by SoulJa on 2017/8/14.
//
//

#import "SJNoticeCycleViewCell.h"
#import "Masonry/Masonry.h"

@implementation SJNoticeCycleViewCell

#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //这题背景色
        self.backgroundColor = [UIColor colorWithRed:204/255.0 green:233/255.0 blue:249/255.0 alpha:1.0];
        //左端视图
        _iconImageView  = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
        //右端Label
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:0/255.0 green:148/255.0 blue:225/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return self;
}

#pragma mark - 布局
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    __weak SJNoticeCycleViewCell *weakSelf = self;
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.contentView.mas_leading).offset(16);
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.iconImageView.mas_trailing).offset(10);
        make.trailing.equalTo(weakSelf.contentView.mas_trailing);
        make.top.equalTo(weakSelf.contentView.mas_top);
        make.height.equalTo(weakSelf.contentView.mas_height);
    }];
}

#pragma mark - 设置通知
- (void)setNotice:(NSString *)notice {
    if (_notice != notice) {
        _notice = notice;
    }
    _titleLabel.text = notice;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
