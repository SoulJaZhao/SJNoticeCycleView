//
//  SJNoticeCycleView.m
//  Pods
//
//  Created by SoulJa on 2017/8/14.
//
//

#import "SJNoticeCycleView.h"
#import "SJNoticeCycleViewCell.h"

static const CGFloat kDefaultCycleTime = 3.0;

static NSString *cellId = @"cellId";

@interface SJNoticeCycleView () <
UITableViewDataSource,
UITableViewDelegate
>

/** tableView **/
@property (nonatomic, strong) UITableView *tableView;
/** 数据源 **/
@property (nonatomic, strong) NSMutableArray *notices;
/** 当前索引 **/
@property (nonatomic, assign) NSInteger currentIndex;
/** 循环Timer **/
@property (nonatomic, strong) NSTimer *cycleTimer;
@end

@implementation SJNoticeCycleView
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame TitleImage:(UIImage *)titleImage NoticeList:(NSArray *)noticeList {
    self = [super initWithFrame:frame];
    if (self) {
        //添加tableView
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        _tableView.estimatedRowHeight = frame.size.height;
        _tableView.rowHeight = frame.size.height;
        _tableView.separatorStyle =UITableViewCellSelectionStyleNone;
        [_tableView setScrollEnabled:NO];
        [_tableView registerClass:[SJNoticeCycleViewCell class] forCellReuseIdentifier:cellId];
        [self addSubview:_tableView];
        //默认循环时间
        _cycleTime = kDefaultCycleTime;
        //标题数组
        self.noticeList = noticeList;
        //当前索引
        _currentIndex = 0;
        //默认title图片
        _titleImage = titleImage;
    }
    return self;
}

#pragma mark - noticeList setter方法
- (void)setNoticeList:(NSArray *)noticeList {
    _noticeList = noticeList;
    //设置数据源
    _notices = [NSMutableArray arrayWithArray:noticeList];
    [_notices addObject:[noticeList firstObject]];
    [_tableView reloadData];
    //启动Timer
    [self setupCycleTimer];
}

#pragma mark - 循环时间  setter
- (void)setCycleTime:(CGFloat)cycleTime {
    if (_cycleTime != cycleTime) {
        _cycleTime = cycleTime;
    }
    //启动Timer
    [self setupCycleTimer];
}

#pragma mark - 设置cycleTimer
- (void)setupCycleTimer {
    //首先销毁Timer
    [self destroyCycleTimer];
    //创建Timer
    __weak SJNoticeCycleView *weakSelf = self;
    
    if (_noticeList.count <= 1) {
        return;
    } else {
        _cycleTimer = [NSTimer timerWithTimeInterval:self.cycleTime repeats:YES block:^(NSTimer * _Nonnull timer) {
            //至最后一个cell
            if (weakSelf.currentIndex == weakSelf.notices.count - 1) {
                weakSelf.currentIndex = 0;
                [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
            }
            weakSelf.currentIndex++;
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }];
        [_cycleTimer setFireDate:[NSDate date]];
        [[NSRunLoop currentRunLoop] addTimer:_cycleTimer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - 销毁cycleTimer
- (void)destroyCycleTimer {
    if (_cycleTimer) {
        [_cycleTimer invalidate];
        _cycleTimer = nil;
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _notices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SJNoticeCycleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[SJNoticeCycleViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.iconImageView.image =  _titleImage;
    cell.notice = [_notices objectAtIndex:indexPath.row];
    return cell;
}

//点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(noticeCycleView:didSelectNoticeAtIndex:)]) {
        [_delegate noticeCycleView:self didSelectNoticeAtIndex:indexPath.row];
    }
}

#pragma mark - 销毁
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self destroyCycleTimer];
    }
}

- (void)dealloc {
    //销毁Timer
    [self destroyCycleTimer];
}
@end
