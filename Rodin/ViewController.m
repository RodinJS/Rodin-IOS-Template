//
//  ViewController.m
//  Rodin
//
//  Created by Asatur Galstyan on 9/19/16.
//  Copyright © 2016 RealizeIt, LLC. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () {
    
    BOOL cardboardMode;
}

@property (nonatomic, strong) WKWebView *wkWebView;

@end



@implementation ViewController

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    cardboardMode = NO;
    
    [self setupWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self loadWebView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupWebView {
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:wkWebConfig];
    _wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _wkWebView.scrollView.scrollEnabled = NO;
    
    [self.view addSubview:_wkWebView];
    [self.view sendSubviewToBack:_wkWebView];
    _wkWebView.backgroundColor = [UIColor clearColor];
    _wkWebView.opaque = NO;

}

- (void)loadWebView {
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSString *rodinUrl = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"RodinUrl"];
    
    NSURL *url = [NSURL URLWithString:rodinUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
}

@end
