//
//  WebviewContainerController.m
//  WebviewContainer
//
//  Created by Tim O'Donnell on 5/22/14.
//  Copyright (c) 2014 ShopPad. All rights reserved.
//

#import "WebviewContainerController.h"

@interface WebviewContainerController ()

@end

@implementation WebviewContainerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    
    NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"url"];
    if (url == nil) {
        url = @"https://www.google.com";
    }
    [self loadWithURL:[NSURL URLWithString:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Getters/Setters

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.delegate = self;
    }
    return _webView;
}

- (void)setWebView:(UIWebView *)webView
{
    _webView = webView;
}

#pragma mark - Updating View Frames

- (void)updateViews
{
    self.webView.frame = self.view.bounds;
    self.webView.delegate = self;
}

#pragma mark - Status Bar

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Rotation

- (BOOL)shouldAutorotate {
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self updateViews];
}

- (void)viewDidLayoutSubviews {
    [self updateViews];
}

#pragma mark - UIWebView Delegation

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%s %@",__func__,error);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    webView.keyboardDisplayRequiresUserAction = NO;
    NSLog(@"%s '%@'",__func__,[[webView.request URL] absoluteString]);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%s '%@'",__func__,[[request URL] absoluteString]);
    return YES;
}

#pragma mark - Loading the App

- (void)loadWithURL:(NSURL *)url
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[self.webView scrollView] setBounces:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
