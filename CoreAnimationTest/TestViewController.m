//
//  TestViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/13.
//

#import "TestViewController.h"
#import <WebKit/WebKit.h>

#define WEB_URL          @"https://passport-stg.muji.com.cn/muji.mpp/static/giftCoupon/exchange_rule.html"

@interface TestViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *couponWebView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.couponWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.couponWebView.navigationDelegate = self;
    self.couponWebView.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.couponWebView];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:WEB_URL]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20];
    NSDictionary *cachedHeaders = [[NSUserDefaults standardUserDefaults] objectForKey:WEB_URL];
    //设置request headers (带上上次的请求头下面两参数一种就可以，也可以两个都带上)
    if (cachedHeaders) {
        NSString *etag = [cachedHeaders objectForKey:@"Etag"];
        if (etag) {
            [request setValue:etag forHTTPHeaderField:@"If-None-Match"];
        }
        NSString *lastModified = [cachedHeaders objectForKey:@"Last-Modified"];
        if (lastModified) {
            [request setValue:lastModified forHTTPHeaderField:@"If-Modified-Since"];
        }
    }
    
    [self.couponWebView loadRequest:request];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"httpResponse == %@", httpResponse);
        // 根据statusCode设置缓存策略
        if (httpResponse.statusCode == 304 || httpResponse.statusCode == 0) {
            [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
        }
        else {
            [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
            // 保存当前的NSHTTPURLResponse
            [[NSUserDefaults standardUserDefaults] setObject:httpResponse.allHeaderFields forKey:WEB_URL];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        // 重新刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.couponWebView reload];
        });
        
    }] resume];
    
//    [self.couponWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:WEB_URL]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
