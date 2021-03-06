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

    NSMutableArray *buttons = [NSMutableArray array];
    for (int i=0; i<15; i++) {
        RFToolbarButton *exampleButton = [RFToolbarButton buttonWithTitle:@"Example"];
        
        [exampleButton addEventHandler:^(id sender){
            [_textView insertText:@"You pressed a button!"];
        } forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:exampleButton];
    }
    
    _textView.inputAccessoryView = [RFKeyboardToolbar toolbarViewWithButtons:buttons];
        
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
#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    [[RFKeyboardToolbar appearance] setBlurEffectStyle:UIBlurEffectStyleDark];
#endif
    
    [[RFToolbarButton appearance] setButtonBorderColor:[UIColor purpleColor]];
    [[RFToolbarButton appearance] setBackgroundColor:[UIColor greenColor]];
    [[RFToolbarButton appearance] setTextColor:[UIColor redColor]];
    
    [_textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_textView becomeFirstResponder];
    });
}

@end
