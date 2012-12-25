//
//  ViewController.h
//  SK3
//
//  Created by nashibao on 2012/11/30.
//  Copyright (c) 2012年 s-cubism. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NATextField.h"

@interface BrowserViewController : UIViewController<UIWebViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSString *initialSource;
@property (nonatomic) BOOL *isLoading;
@property (nonatomic) NSInteger load_cnt;

- (IBAction)close:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)reflesh:(id)sender;
- (IBAction)action:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refleshButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NATextField *textInput;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;

@end
