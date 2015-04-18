//
//  WebSiteViewController.m
//  My Rep (Rain)
//
//  Created by Parker Rushton on 4/16/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "WebSiteViewController.h"
#import "Colors.h"
@import WebKit;

@interface WebSiteViewController () <WKNavigationDelegate>

//@property (strong, nonatomic) Representative *rep;
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic)  IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation WebSiteViewController

-(void)updateWithRep:(Representative *)rep {
    self.rep = rep;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //WKWebView
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.allowsBackForwardNavigationGestures = YES;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    //ActivityIndicator
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    if ([self.rep.party isEqualToString:@"R"]) {
        self.activityIndicator.color = RepublicanRed;
    } else if ([self.rep.party isEqualToString:@"D"]) {
        self.activityIndicator.color = DemocratBlue;
    }
    [self.activityIndicator startAnimating];
    [self.activityIndicator setHidesWhenStopped:YES];
    [self.webView addSubview:self.activityIndicator];
    
    //Navigation Controller
    self.navigationController.navigationBarHidden = NO;
    self.title = self.rep.name;
    [self configureView];
}

-(void)configureView {
    
    NSURL *url = [NSURL URLWithString:self.rep.website];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    if (self.webView) {
        [self.webView loadRequest:urlRequest];
    }
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.webView = webView;
    [self.activityIndicator stopAnimating];
    
    
}

@end
