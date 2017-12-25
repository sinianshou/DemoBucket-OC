//
//  UIScrollVC.m
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/24.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import "UIScrollVC.h"
#import <WebKit/WebKit.h>
@interface UIScrollVC ()<UIGestureRecognizerDelegate>

@end

@implementation UIScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView * table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:table];
    
    //创建一个WKWebView的配置对象
    WKWebViewConfiguration *configur = [[WKWebViewConfiguration alloc] init];
    //设置configur对象的preferences属性的信息
    WKPreferences *preferences = [[WKPreferences alloc] init];
    configur.preferences = preferences;
    //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
    preferences.javaScriptEnabled = YES;
    WKUserContentController *userContentController = [[WKUserContentController alloc]init];
    NSString *js = @"function goMore (){\
    window.webkit.messageHandlers.clickVideoButton.postMessage({methodName:'clickVideoButton'});\
    }";
    WKUserScript *scrpt = [[WKUserScript alloc]initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    [userContentController addUserScript:scrpt];
    configur.userContentController = userContentController;
    WKWebView * web = [[WKWebView alloc]initWithFrame:table.bounds configuration:configur];
    UIView * v = [[UIView alloc] initWithFrame:web.bounds];
    [v addSubview:web];
    table.tableHeaderView = v;
    
    NSString *string = [NSString stringWithFormat:@"https://www.baidu.com"];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载新闻详情网页
    [web loadRequest:request];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(actionHandle:)];
    longPress.minimumPressDuration = 1;
    longPress.delegate = self;
    [web addGestureRecognizer:longPress];
    
    // Do any additional setup after loading the view.
}
-(void)actionHandle:(UILongPressGestureRecognizer *)longPressRecognizer
{
    printf("\nComplete \n%s", __func__);
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

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    printf("Complete %s", __func__);
    return YES;
}

// called when the recognition of one of gestureRecognizer or otherGestureRecognizer would be blocked by the other
// return YES to allow both to recognize simultaneously. the default implementation returns NO (by default no two gestures can be recognized simultaneously)
//
// note: returning YES is guaranteed to allow simultaneous recognition. returning NO is not guaranteed to prevent simultaneous recognition, as the other gesture's delegate may return YES
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    printf("Complete %s", __func__);
    return YES;
}

// called once per attempt to recognize, so failure requirements can be determined lazily and may be set up between recognizers across view hierarchies
// return YES to set up a dynamic failure requirement between gestureRecognizer and otherGestureRecognizer
//
// note: returning YES is guaranteed to set up the failure requirement. returning NO does not guarantee that there will not be a failure requirement as the other gesture's counterpart delegate or subclass methods may return YES

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0)
//{
//    printf("Complete %s", __func__);
//    return YES;
//}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0)
//{
//    printf("Complete %s", __func__);
//    return YES;
//}

// called before touchesBegan:withEvent: is called on the gesture recognizer for a new touch. return NO to prevent the gesture recognizer from seeing this touch
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    printf("Complete %s", __func__);
    return YES;
}

// called before pressesBegan:withEvent: is called on the gesture recognizer for a new press. return NO to prevent the gesture recognizer from seeing this press
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press
{
    printf("Complete %s", __func__);
    return YES;
}

@end
