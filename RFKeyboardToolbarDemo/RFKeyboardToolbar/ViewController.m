//
//  ViewController.m
//  RFKeyboardToolbarDemo
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import "ViewController.h"
#import "RFKeyboardToolbar.h"
#import "RFToolbarButton.h"

@interface ViewController ()

@property (nonatomic,strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"RFKeyboardToolbar";
    
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    
    RFToolbarButton *exampleButton = [RFToolbarButton buttonWithTitle:@"Example"];
    
    [exampleButton addEventHandler:^{
        [_textView insertText:@"You pressed a button!"];
    } forControlEvents:UIControlEventTouchUpInside];
    
    _textView.inputAccessoryView = [RFKeyboardToolbar toolbarViewWithButtons:@[exampleButton]];
        
    [self.view addSubview:_textView];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo
                                                  target:self
                                                  action:@selector(reTheme)];
    
    
}

-(void) reTheme
{
    [[RFKeyboardToolbar appearance] setToolbarBorderColor:[UIColor redColor]];
    [[RFKeyboardToolbar appearance] setToolbarBackgroundColor:[UIColor blueColor]];
    [[RFToolbarButton appearance] setBorderColor:[UIColor purpleColor]];
    [[RFToolbarButton appearance] setBackgroundColor:[UIColor greenColor]];
    [[RFToolbarButton appearance] setTextColor:[UIColor redColor]];
    
    [_textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_textView becomeFirstResponder];
    });
}

@end
