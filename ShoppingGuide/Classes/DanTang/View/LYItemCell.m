//
//  LYItemCell.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/3.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYItemCell.h"
#import "LYItem.h"
#import "UIImageView+WebCache.h"
#import "LYNetworkTool.h"

@interface LYItemCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UIButton *placeBtn;

@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LYItemCell


- (void)setItem:(LYItem *)item {
    
    _item = item;
    
    __weak typeof(self)weakSelf = self;
    self.titleLabel.text = item.title;
    [self.favoriteBtn setTitle:[NSString stringWithFormat:@" %ld  ",item.likes_count] forState:UIControlStateNormal];
    self.favoriteBtn.selected = (item.status == 1 ? YES : NO);
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.placeBtn.hidden = YES;
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.favoriteBtn.layer.cornerRadius = self.favoriteBtn.mr_height * 0.5;
    self.favoriteBtn.layer.masksToBounds = YES;
    // 开启离屏渲染
    self.favoriteBtn.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    self.favoriteBtn.layer.shouldRasterize = YES;
    
    self.bgImage.layer.cornerRadius = 8;
    self.bgImage.layer.masksToBounds = YES;
     // 开启离屏渲染
    self.bgImage.layer.shouldRasterize = YES;
    self.bgImage.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

// 点赞按钮事件
- (IBAction)likeBtnClick:(UIButton *)btn {
        NSString *url = nil;
        if(btn.selected) {  // 已经被选中
            url = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/posts/%ld/like?", self.item.itemID];
            // 向服务器发送取消点赞请求
            [[LYNetworkTool sharedNetworkTool] loadDataInfoDelete:url parameters:nil success:^(id  _Nullable responseObject) {
                NSString *message = responseObject[@"message"];
                if([message isEqualToString:@"OK"]) {   // 操作成功, 后台已经更新
                    // 发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LYThemeLikeNotification" object:nil];
                    btn.selected = !btn.selected;
                }
            } failure:^(NSError * _Nullable error) {
                
            }];
        }else { // 未选中
           url = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/posts/%ld/like", self.item.itemID];
            // 向服务器发送点赞请求
            [[LYNetworkTool sharedNetworkTool] loadDataInfoPost:url parameters:nil success:^(id  _Nullable responseObject) {
                NSString *message = responseObject[@"message"];
                if([message isEqualToString:@"OK"]) {   // 操作成功, 后台已经更新
                    // 发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LYThemeLikeNotification" object:nil];
                    btn.selected = !btn.selected;
                }
            } failure:^(NSError * _Nullable error) {
                
            }];
        }
}

- (void)setFrame:(CGRect)frame {
    
    static CGFloat const margin = 10;
    
    frame.size.width -= 2 * margin;
    frame.origin.x = margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
