//
//  LYDanTangController.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/1.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYDanTangController.h"
#import "LYSearchController.h"
#import "LYChannelController.h"
#import "LYNetworkTool.h"
#import "LYChannels.h"

#define scrollViewInsetHeight self.view.mr_height - 100 - self.tabBarController.tabBar.mr_height

@interface LYDanTangController ()<UIScrollViewDelegate>

/**
 *  频道数组
 */
@property (nonatomic, strong) NSArray *channels;
// 头部标题视图
@property (nonatomic, weak) UIView *titlesView;
// 当前选中按钮
@property (nonatomic, weak) UIButton *selectedBtn;

/**
 *  红色指示条
 */
@property (nonatomic, weak) UIView *indicatorView;

/**
 *  内容视图
 */
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation LYDanTangController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNav];
    // 请求头部标题数据
    [self loadTitlesViewInfo];
}

/**
 *  设置导航栏
 */
- (void)setNav {
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Feed_SearchBtn_18x18_"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

/**
 *  设置视图标题栏
 */
- (void)loadTitlesViewInfo {
    
    __weak typeof(self)weakSelf = self;
    // 网络请求地址
    NSString *url = [NSString stringWithFormat:@"%@%@", BaseAPI, @"v2/channels/preset?gender=1&generation=1"];
    // 发送网络请求
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:url parameters:nil success:^(id  _Nullable responseObject) {
        // 将返回的数据转化为对象数组存入当前数组用于设置标题
        NSArray *dictArray = responseObject[@"data"][@"channels"];
        weakSelf.channels = [LYChannels mj_objectArrayWithKeyValuesArray:dictArray];
        // 设置头部标题
        [weakSelf setUpTitles];
        // 设置内容视图
        [weakSelf setContentView];
        
    } failure:nil];
}

/**
 *  初始顶部标签栏
 */
- (void)setUpTitles
{
    // 标签栏整体
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = MRRGBColor(240, 240, 240);
    titleView.mr_y = LYNavBarHeight;
    titleView.mr_width = self.view.mr_width;
    titleView.mr_height = LYTitlesViewH;
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = MRGlobalBg;
    indicatorView.mr_height = 2;
    indicatorView.mr_y = titleView.mr_height - indicatorView.mr_height;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 内部子标签
    NSInteger count = self.channels.count;
    CGFloat width = self.view.mr_width / count;
    CGFloat height = titleView.mr_height - 2;
    
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        button.mr_x = i * width;
        button.mr_width = width;
        button.mr_height = height;
        button.tag = i;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        LYChannels *channel = self.channels[i];
        [button setTitle:channel.name forState:UIControlStateNormal];
        // [button layoutIfNeeded];    // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:MRGlobalBg forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        // 添加子控制器
        [self addChildVc:self.channels[i]];
        [titleView addSubview:button];
        
        // 默认选中第一个按钮
        if(i == 0) {
            button.enabled = NO;
            self.selectedBtn = button;
            [button.titleLabel sizeToFit]; // 让按钮根据文字内容设置尺寸
            self.indicatorView.mr_width = button.titleLabel.mr_width;
            self.indicatorView.mr_centerX = button.mr_centerX;
        }
    }
}


/**
 *  初始化内容视图
 */
- (void)setContentView {
    
    // 取消自动设置UIScrollView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.contentSize = CGSizeMake(self.channels.count * self.view.mr_width, 0);
    [self.view insertSubview:contentView belowSubview:self.titlesView];
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}


/**
 *  添加子控制器
 */
- (void)addChildVc:(LYChannels *)channel {
    LYChannelController *channelVc = [[LYChannelController alloc] init];
    channelVc.channesID = channel.channelsID;
    [self addChildViewController:channelVc];
}


// 选中按钮的点击事件
- (void)titleClick:(UIButton *)button {
    
    NSInteger index = button.tag;
    // 修改选中按钮状态
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.mr_width = button.titleLabel.mr_width;
        self.indicatorView.mr_centerX = button.mr_centerX;
        
    }];
    
    // 滚动
    CGPoint offSet = self.contentView.contentOffset;
    offSet.x = index * self.contentView.mr_width;
    
    // 只有当scrollView偏移量前后不同的时候才会回调scrollViewDidEndScrollingAnimation方法,若两次的偏移量相同,则不会回调
    [self.contentView setContentOffset:offSet animated:YES];
}


/**
 *  搜索点击
 */
- (void)search {
    LYSearchController *searchVc = [[LYSearchController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark - <UIScrollViewDelegate>

// 当每次scrollView切换的时候就会调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.mr_width;
    
    // 计算下标
    NSInteger index = scrollView.contentOffset.x / width;
    
    // 拿到对应下标的控制器
    UITableViewController *willShowVc = self.childViewControllers[index];
    
    if([willShowVc isViewLoaded]) { // 如果已经显示, 直接返回
        return;
    }
    
    willShowVc.view.mr_x = index * width;
    willShowVc.view.mr_y = 0;   // 设置控制器view的y值为0, 控制器view的默认y为20(状态栏高度)
    willShowVc.view.mr_height = self.view.mr_height;
    
    [scrollView addSubview:willShowVc.view];
}


// 当手指拖动scrollView滑动的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:_contentView];
    
    CGFloat width = scrollView.mr_width;
    
    // 计算下标
    NSInteger index = scrollView.contentOffset.x / width;
    
    UIButton *btn = self.titlesView.subviews[index + 1];
    
    [self titleClick:btn];
}

#pragma mark - lazy load

- (NSArray *)channels {
    
    if(!_channels) {
        
        _channels = [NSArray array];
        
    }
    
    return _channels;
}



@end
