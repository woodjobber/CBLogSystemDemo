//
//  NSObject+CBReverseComparison.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-14.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "GNUMLogReviewViewController.h"
#import "GNUMLogSystem.h"

@interface GNUMLogReviewViewController () <UIWebViewDelegate>

@property (nonatomic, strong) NSURL *currentLogPathURL;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UITextView *readView;

@end

@implementation GNUMLogReviewViewController

- (id)initWithLogPathURL:(NSURL *)logPathURL;
{
    self = [super init];
    if (self) {
        self.currentLogPathURL = logPathURL;
        self.title = @"Info";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
       self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.webView.backgroundColor = [UIColor whiteColor];
        self.webView.translatesAutoresizingMaskIntoConstraints = NO;
        self.webView.delegate = self;
        //[self.view addSubview:self.webView];
    
//        NSDictionary *views = NSDictionaryOfVariableBindings(_webView);
//        NSMutableArray *constraits = [NSMutableArray array];
//        [constraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_webView]|" options:0 metrics:nil views:views]];
//        [constraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_webView]|" options:0 metrics:nil views:views]];
//        [self.view addConstraints:constraits];
    
   
    if (self.currentLogPathURL !=nil) {
        //[self  performSelectorOnMainThread:@selector(loadLogData) withObject:nil waitUntilDone:YES];
    }
    
    NSString *context = [NSString stringWithContentsOfFile:(NSString *)self.currentLogPathURL encoding:NSUTF8StringEncoding error:nil];
    _readView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _readView.scrollEnabled = YES;
    [_readView setTextColor:[UIColor blackColor]];
    [_readView setEditable:NO];
    [_readView setFont:[UIFont systemFontOfSize:13.0f]];
    [_readView setText:context];
     self.readView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_readView];

}


- (void)loadLogData
{
 
    
    NSString *body = [NSString stringWithContentsOfURL:self.currentLogPathURL encoding:NSUTF8StringEncoding error:nil];
    if (!body)
    {
     
        body = [NSString stringWithContentsOfURL:self.currentLogPathURL encoding:0x80000632 error:nil];
    }
    if (!body) {
        
        body = [NSString stringWithContentsOfURL:self.currentLogPathURL encoding:0x80000631 error:nil];
    }
    if (body) {
       
        NSString* responseStr = [NSString stringWithFormat:
                                 @"<HTML>"
                                 "<head>"
                                 "<title>Text View</title>"
                                 "</head>"
                                 "<BODY>"
                                 "<pre>"
                                 "%@"
                                 "/pre>"
                                 "</BODY>"
                                 "</HTML>",
                                 body];
    
         [_webView loadHTMLString:responseStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        
    }
    
     [self.webView reload];
    
}



#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize webviewContentSize = webView.scrollView.contentSize;
    [webView.scrollView scrollRectToVisible:CGRectMake(0, webviewContentSize.height - webView.bounds.size.height, webView.bounds.size.width, webView.bounds.size.height) animated:NO];
}

@end
