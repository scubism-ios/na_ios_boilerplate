//
//  ViewController.m
//  SK3
//
//  Created by nashibao on 2012/11/30.
//  Copyright (c) 2012年 s-cubism. All rights reserved.
//

#import "BrowserViewController.h"

#import "NANetworkActivityIndicatorManager.h"

#import "SFKImage.h"

#import "UIView+na.h"

@interface BrowserViewController ()

@end

@implementation BrowserViewController

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
    NSString *escaped = [self.initialSource stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:escaped]]];
    [self update];
    
    [self.backButton setImage:[SFKImage imageNamed:@"back"]];
    [self.nextButton setImage:[SFKImage imageNamed:@"next"]];
    [self.refleshButton setImage:[SFKImage imageNamed:@"reload"]];
    [self.actionButton setImage:[SFKImage imageNamed:@"safari"]];
}

- (void)update{
    [self.backButton setEnabled:[self.webView canGoBack]];
    [self.nextButton setEnabled:[self.webView canGoForward]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self update];
    self.load_cnt += 1;
    [[NANetworkActivityIndicatorManager sharedManager] incrementActivityCount:nil option:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self update];
    self.load_cnt -= 1;
    [[NANetworkActivityIndicatorManager sharedManager] decrementActivityCount:nil];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self update];
    self.load_cnt -= 1;
    [[NANetworkActivityIndicatorManager sharedManager] decrementActivityCount:nil];
}

- (IBAction)close:(id)sender {
    for (int i=0; i<self.load_cnt; i++) {
        [[NANetworkActivityIndicatorManager sharedManager] decrementActivityCount:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self.webView goBack];
}

- (IBAction)next:(id)sender {
    [self.webView goForward];
}

- (IBAction)reflesh:(id)sender {
    [self.webView reload];
}

- (IBAction)action:(id)sender {
    [[UIApplication sharedApplication] openURL:self.webView.request.URL];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([[textField text] length] > 0){
        NSString *escaped = [[textField text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"https://www.google.co.jp/search?q=", escaped]]]];
    }
}

@end
