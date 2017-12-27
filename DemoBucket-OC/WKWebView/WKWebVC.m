//
//  WKWebVC.m
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/25.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import "WKWebVC.h"
#import <WebKit/WebKit.h>

@interface WKWebVC ()<UIScrollViewDelegate, WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) NSMutableArray *allUrlArray;
@property (nonatomic,strong) UIScrollView * bgView;
@end

@implementation WKWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    objs[i].onclick=function(){ \
//        window.webkit.messageHandlers.clickJS.postMessage({methodName:'clickJS'});\
//    };\
    
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var imgs = document.getElementsByTagName('img');\
    for(var i=0;i<imgs.length;i++){\
    imgs[i].click(function () {window.webkit.messageHandlers.clickJS.postMessage({methodName:'clickJS'});}\
    }\
    };\
    function clickJS01{\
    window.webkit.messageHandlers.clickJS01.postMessage({methodName:'clickJS01'});\
    }";
    // js配置
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//    [userContentController addScriptMessageHandler:self name:@"jsCallOC"];
    // js注入，注入一个alert方法，页面加载完毕弹出一个对话框。
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:jsGetImages injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];// forMainFrameOnly:NO(全局窗口)，yes（只限主窗口）
    [userContentController addUserScript:userScript];
    
    // WKWebView的配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.selectionGranularity = WKSelectionGranularityCharacter;
    configuration.userContentController = userContentController;
    
    // 显示WKWebView
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _webView.opaque = NO;
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
    _webView.scrollView.bounces=NO;
    _webView.scrollView.decelerationRate=UIScrollViewDecelerationRateNormal;
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://test.zhongchao.9hgame.com/h5/sun/shenhuanews/?deviceToken=0"]];//百度随便找个地址 主要验证demo使用
    [_webView loadRequest:request];
    _webView.scrollView.delegate = self;
    
    
//    NSString *string = [NSString stringWithFormat:@"https://juejin.im/post/5a419435f265da431c708c75"];
//    NSURL *url = [NSURL URLWithString:string];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //加载新闻详情网页
//    [web loadRequest:request];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // addScriptMessageHandler 很容易导致循环引用
    // 控制器 强引用了WKWebView,WKWebView copy(强引用了）configuration， configuration copy （强引用了）userContentController
    // userContentController 强引用了 self （控制器）
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"clickJS"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"clickJS01"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 因此这里要记得移除handlers
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"clickJS"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"clickJS01"];
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

#pragma mark ---- WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *requestString = [[navigationAction.request URL] absoluteString];
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        NSLog(@"imageUrl is %@", imageUrl);
    }
    
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    //注入自定义的js方法后别忘了调用 否则不会生效（不调用也一样生效了，，，不明白）
    [webView evaluateJavaScript:@"getImages()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSString *urlResurlt = result;
        _allUrlArray = [NSMutableArray arrayWithArray:[urlResurlt componentsSeparatedByString:@"L+Q+X"]];
        if (_allUrlArray.count >= 2) {
            [_allUrlArray removeLastObject];// 此时数组为每一个图片的url
        }
    }];
    [webView evaluateJavaScript:@"alert()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    }];
}
//- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));

#pragma mark ---- WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"message.name is %@", message.name);
}

#pragma mark ---- WKUIDelegate

//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
//{
//    return webView;
//}
//- (void)webViewDidClose:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0))
//{
//
//}
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
//{
//    // 确定按钮
//    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }];
//    // alert弹出框
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:alertAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//}
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
//{
//    completionHandler(YES);
//}
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
//{
//    completionHandler(@"defaultText");
//}
//- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo API_AVAILABLE(ios(10.0))
//{
//    return YES;
//}
////- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions API_AVAILABLE(ios(10.0))
////{
////
////}
//- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController API_AVAILABLE(ios(10.0))
//{
//
//}
@end
