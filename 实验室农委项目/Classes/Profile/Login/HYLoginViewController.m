//
//  HYLoginViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/21.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYLoginViewController.h"
#import "MBProgressHUD.h"
#import "ShopModel.pbobjc.h"
#import <AFNetworking/AFNetworking.h>

@interface HYLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation HYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _accountTextField.delegate = self;
    _pwdTextField.delegate = self;
    self.navigationController.title = @"注册";
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)confirmBtnClick:(id)sender {
    
    NSString *account = self.accountTextField.text;
    NSString *pwd = self.pwdTextField.text;
    
    if (account.length <= 0 || pwd.length <= 0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
        hud.label.text = @"账号密码不能为空";
        hud.mode = MBProgressHUDModeText;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1.0f];
    }
    
    RegisterProto *reg = [[RegisterProto alloc] init];
    reg.username = account;
    reg.password = pwd;
    
    NSData *regData = [reg data];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *host = @"47.92.119.236:11113";
    
    NSDictionary *dict = @{@"type": @"tReqTypeRegister"};
    
    manager POST:host parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:<#^(NSProgress * _Nonnull uploadProgress)uploadProgress#> success:<#^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)success#> failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.pwdTextField) {
        [self confirmBtnClick: textField];
    }
    [textField resignFirstResponder];
    return YES;
}


@end
