//
//  LYCommentCell.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/19.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYCommentCell.h"
#import "LYComment.h"
#import "LYUser.h"
#import "UIImageView+WebCache.h"
#import "NSDate+MRExtension.h"

@interface LYCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation LYCommentCell

- (void)setComment:(LYComment *)comment {
    _comment = comment;
    LYUser *user = comment.user;
    NSString *url = user.avatar_url;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nickNameLabel.text = user.nickname;
    self.contentLabel.text = comment.content;
    self.timeLabel.text = [NSDate dateWithTimeStamp: comment.created_at];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
