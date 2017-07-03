//
//  HYLoginViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/21.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYLoginViewController.h"

@interface HYLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation HYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)confirmBtnClick:(id)sender {
//    if ([self.accountTextField.text isEqualToString:@"123"] && [self.pwdTextField.text isEqualToString:@"123"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:HYRootViewControllerChangeName object:nil];
//    }

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resignFirstResponder];
}
@end
