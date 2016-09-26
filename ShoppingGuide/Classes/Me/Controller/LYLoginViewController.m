//
//  LYLoginViewController.m
//  ShoppingGuide
//
//  Created by coderLL on 16/9/18.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "LYLoginViewController.h"
#import "LYNetworkTool.h"
#import "MJExtension.h"
#import "LYUser.h"
#import "SVProgressHUD.h"

@interface LYLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LYLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.phoneNum becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
}

- (void)setupNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registe)];
    
    self.phoneNum.delegate = self;
    self.pwd.delegate = self;
}

- (IBAction)loginIn:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.phoneNum.text;
    params[@"password"] = self.pwd.text;
    
    [[LYNetworkTool sharedNetworkTool] loadDataInfoPost:@"http://api.dantangapp.com/v1/account/signin" parameters:params success:^(id  _Nullable responseObject) {
        
        NSString *status = responseObject[@"message"];
        if([status isEqualToString:@"OK"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            LYUser *user = [LYUser mj_objectWithKeyValues:responseObject[@"data"]];
            
            if(weakSelf.block) {
                weakSelf.block(user);
            }
            
            // 退出登录界面
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
    } failure:^(NSError * _Nullable error) {
        
         [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
}

- (void)cancel:(UIBarButtonItem *)item {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)registe {
    
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.loginBtn.enabled = (self.phoneNum.text.length > 0 && self.pwd.text.length > 0) ? YES : NO;
    return YES;
}


@end
