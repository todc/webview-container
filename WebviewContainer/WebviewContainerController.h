//
//  WebviewContainerController.h
//  WebviewContainer
//
//  Created by Tim O'Donnell on 5/22/14.
//  Copyright (c) 2014 ShopPad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebviewContainerController : UIViewController <UIWebViewDelegate> {
    UIWebView* _webView;
}

@property (readwrite) UIWebView *webView;

@end
