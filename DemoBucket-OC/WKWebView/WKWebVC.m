//
//  WKWebVC.m
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/25.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import "WKWebVC.h"
#import <WebKit/WebKit.h>

@interface WKWebVC ()<UIWebViewDelegate, WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation WKWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建一个WKWebView的配置对象
    WKWebViewConfiguration *configur = [[WKWebViewConfiguration alloc] init];
    //设置configur对象的preferences属性的信息
    WKPreferences *preferences = [[WKPreferences alloc] init];
    configur.preferences = preferences;
    //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
    preferences.javaScriptEnabled = YES;
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    NSString *testJS = @"function testJS (){ \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) { \
    var img = imgs[i]; \
    img.onclick = clickJS (); \
    } \
    }";
    WKUserScript *testJSscrpt = [[WKUserScript alloc]initWithSource:testJS injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    [userContentController addUserScript:testJSscrpt];
    
    NSString *clickJS = @"function clickJS (){\
    window.webkit.messageHandlers.clickJS.postMessage({methodName:'clickJS'});\
    }";
    WKUserScript *clickJSscrpt = [[WKUserScript alloc]initWithSource:clickJS injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    [userContentController addUserScript:clickJSscrpt];
    configur.userContentController = userContentController;
    WKWebView * web = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configur];
    [self.view addSubview:web];
//    web.UIDelegate = self;
    web.navigationDelegate = self;
    
    NSString *string = [NSString stringWithFormat:@"http://tech.ifeng.com/a/20171225/44818167_0.shtml"];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载新闻详情网页
    [web loadRequest:request];
    self.webView = web;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // addScriptMessageHandler 很容易导致循环引用
    // 控制器 强引用了WKWebView,WKWebView copy(强引用了）configuration， configuration copy （强引用了）userContentController
    // userContentController 强引用了 self （控制器）
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"clickJS"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 因此这里要记得移除handlers
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"clickJS"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark ---- UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
//- (void)webViewDidStartLoad:(UIWebView *)webView;
//- (void)webViewDidFinishLoad:(UIWebView *)webView;
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
//
#pragma mark ---- WKNavigationDelegate
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    [self.webView evaluateJavaScript:@"testJS ()" completionHandler:nil];
}
//- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));

#pragma mark ---- WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"message.name is %@", message.name);
}
@end
