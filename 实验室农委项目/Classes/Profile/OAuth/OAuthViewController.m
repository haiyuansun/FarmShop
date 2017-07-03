//
//  OAuthViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/21.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "OAuthViewController.h"
#import "AccountViewModel.h"
#import <SVProgressHUD/SVProgressHUD.h>


@interface OAuthViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation OAuthViewController

#pragma mark - 懒加载
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view = self.webView;
    
    self.navigationController.navigationBar.hidden = NO;
    [self setupUI];
    [self loadOAuthPage];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _webView.delegate = nil;
    [_webView stopLoading];
    //清除缓存
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}
#pragma methods
-(void)setupUI{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"自动填充" style:UIBarButtonItemStylePlain target:self action:@selector(fullBtnClick)];
}

-(void)closeBtnClick{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [SVProgressHUD dismiss];
}
-(void)fullBtnClick{
    NSString *jsString = @"document.getElementById('userId').value = '18600653280' ,document.getElementById('passwd').value = 'qq921103'";
    [_webView stringByEvaluatingJavaScriptFromString:jsString];
}
//请求
/*https://api.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=http://www.example.com/response&response_type=code*/

-(void)loadOAuthPage{
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:@"https://api.weibo.com/oauth2/authorize?client_id="];
    [urlString appendString: HYWeiboAppKey];
    [urlString appendString:@"&redirect_uri="];
    [urlString appendString:HYWeiboRedirectUrl];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
   
}

#pragma UIWebViewDelegate

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD show];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
    //协议方法 返回true 表示当前对象可以正常工作
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSString *urlString = request.URL.absoluteString;
    NSString *query = request.URL.query;
    DLog(@"%@", query);
    NSString *codeStr = @"code=";
    if ([query containsString:codeStr]) {
        NSString *code = [query substringFromIndex:codeStr.length];
        //385de64d2d78fea0c3b0e174199e32ff
//        DLog(@"%@ \n %@", query, code);
        AccountViewModel *viewModel = [[AccountViewModel alloc] init];
        [viewModel loadTokenInfoWithCode:code andFinishBlock:^(NSError *error) {
            DLog(@"%@", error); 
        }];
    }
//    return NO;
    return YES;
}




@end
