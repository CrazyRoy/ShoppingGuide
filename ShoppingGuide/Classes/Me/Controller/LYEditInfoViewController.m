//
//  LYEditInfoViewController.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/20.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYEditInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "LYNetworkTool.h"

@interface LYEditInfoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UITextField *nickName;

/**
 *  图片选择器
 */
@property (nonatomic, strong) UIImagePickerController *pic;

@end

@implementation LYEditInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.nickName becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];  // 设置导航栏
    self.nickName.text = self.name;
    self.iconImage.image = self.image;
    UITapGestureRecognizer *tagGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIconImage)];
    self.iconImage.userInteractionEnabled = YES;
    [self.iconImage addGestureRecognizer:tagGes];
}

// 设置导航栏
- (void)setNav {
    self.title = @"编辑资料";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
}

// 取消
- (void)cancel {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 完成
- (void)finish {
    // 向服务器上传图片修改资料
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"nickname"] = self.nickName.text;
    __weak typeof(self) weakSelf = self;
    [[LYNetworkTool sharedNetworkTool] loadDataInfo:@"http://api.dantangapp.com/v1/users/me" parameters:params success:^(id  _Nullable responseObject) {
        // 退出编辑页面
        [[NSUserDefaults standardUserDefaults] setObject:weakSelf.nickName.text forKey:@"nickname"];
        [[NSUserDefaults standardUserDefaults] synchronize];    // 立即更新
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

// 选择投降
- (void)selectIconImage {
    self.pic = [[UIImagePickerController alloc] init];
    self.pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.pic.allowsEditing = YES;
    self.pic.delegate = self;
    [self presentViewController:self.pic animated:YES completion:nil];
}

#pragma mark - <UIImagePickerControllerDelegate>

/**
 *  3.0
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 数据类型
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){   // 如果选择的是图片
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];   // 编辑之后的图片
        NSData *image_data= UIImageJPEGRepresentation(image, 0.5);
        // 保存图片
        [[NSUserDefaults standardUserDefaults] setObject:image_data forKey:@"avatar_image"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.iconImage.image = [UIImage imageWithData:image_data];
    } else if ([mediaType isEqualToString:@"public.movie"]) {   // 选择视频
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
