//
//  LYProductDetailBottomView.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/19.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYProductDetailBottomView.h"
#import "LYNetworkTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LYProduct.h"
#import "LYDetailChoiceButtonView.h"
#import "LYComment.h"
#import "LYCommentCell.h"

@interface LYProductDetailBottomView ()<LYDetailChoiceDelegate, UIWebViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) LYDetailChoiceButtonView *choiceView;
// 展示图文详情
@property (nonatomic, strong) UIWebView *webView;
// 展示评论
@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, strong) NSArray *comments;

@end

static NSString * const commentCellID = @"commentCellID";

@implementation LYProductDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.choiceView];
    [self addSubview:self.webView];
    [self addSubview:self.commentTableView];

}

- (void)setProduct:(LYProduct *)product {
    _product = product;
    
    
    __weak typeof(self) weakSelf = self;
    
    // 请求图文详情数据
    NSString *detailURL = [NSString stringWithFormat:@"http://api.dantangapp.com/v2/items/%ld", product.productID];
    
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:detailURL parameters:nil success:^(id  _Nullable responseObject) {
        NSString *commentCount = responseObject[@"data"][@"comments_count"];
        [weakSelf.choiceView.commentBtn setTitle:[NSString stringWithFormat:@"评论(%@)", commentCount] forState:UIControlStateNormal];
        NSString *detail_html = responseObject[@"data"][@"detail_html"];
        [weakSelf.webView loadHTMLString:detail_html baseURL:nil];
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    // 请求商品评论数据
    NSString *commentsURL = [NSString stringWithFormat:@"http://api.dantangapp.com/v2/items/%ld/comments", product.productID];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"limit"] = @(20);
    params[@"offset"] = @(0);
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:commentsURL parameters:nil success:^(id  _Nullable responseObject) {
        NSArray *dicts = responseObject[@"data"][@"comments"];
        NSMutableArray *comments = [NSMutableArray array];
        for (NSDictionary *dict in dicts) {
            LYComment *comment = [LYComment mj_objectWithKeyValues:dict];
            [comments addObject:comment];
        }
        weakSelf.comments = comments;
        [weakSelf.commentTableView reloadData]; // 刷新评论数据
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}

- (LYDetailChoiceButtonView *)choiceView {
    
    if(!_choiceView) {
        LYDetailChoiceButtonView *choiceView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LYDetailChoiceButtonView class]) owner:nil options:nil] lastObject];
        choiceView.delegate = self;
        _choiceView = choiceView;
    }
    
    return _choiceView;
}

- (UIWebView *)webView {
    
    if(!_webView) {
        UIWebView *webView = [[UIWebView alloc] init];
        /// 自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = YES;
        webView.dataDetectorTypes = UIDataDetectorTypeAll;
        webView.delegate = self;
        _webView = webView;
    }
    
    return _webView;
}

- (UITableView *)commentTableView {
    
    if(!_commentTableView) {
        UITableView *tv = [[UITableView alloc] init];
        tv.hidden = YES;
        [tv registerNib:[UINib nibWithNibName:NSStringFromClass([LYCommentCell class]) bundle:nil] forCellReuseIdentifier:commentCellID];
        tv.dataSource = self;
        tv.separatorStyle = UITableViewCellSeparatorStyleNone;
        tv.rowHeight = 64;
        _commentTableView = tv;
    }
    
    return _commentTableView;
}

- (NSArray *)comments {
    
    if(!_comments) {
        _comments = [NSArray array];
    }
    
    return _comments;
}

#pragma mark - <LYDetailChoiceButtonViewDelegate>

- (void)descBtnClick {
    self.webView.hidden = NO;
    self.commentTableView.hidden = YES;
}

- (void)commentsBtnClick {
    self.webView.hidden = YES;
    self.commentTableView.hidden = NO;
}

#pragma mark - <UIWebViewDelegate>

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.choiceView.frame = CGRectMake(0, 0, MRScreenW, 45);
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.choiceView.frame), MRScreenW, self.mr_height - 45);
    self.commentTableView.frame = self.webView.frame;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    cell.comment = self.comments[indexPath.row];
    return cell;
}

@end
