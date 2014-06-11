//
//  RFToolbarButton.m
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import "RFToolbarButton.h"

@interface RFToolbarButton ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) eventHandlerBlock buttonPressBlock;

@end

@implementation RFToolbarButton 

+ (instancetype)buttonWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (id)initWithTitle:(NSString *)title {
    _title = title;
    return [self init];
}

- (id)init
{
    CGSize sizeOfText = [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.f]}];
    
    self = [super initWithFrame:CGRectMake(0, 0, sizeOfText.width + 18.104, sizeOfText.height + 10.298)];
    if (self) {
        self.layer.cornerRadius = 3.0f;
        self.layer.borderWidth = 1.0f;
        
        [self setTitle:self.title forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];

        self.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.0];
        _textColor = [UIColor colorWithWhite:0.500 alpha:1.0];
        _borderColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    }
    return self;
}

- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent {
    self.buttonPressBlock = eventHandler;
    [self addTarget:self action:@selector(buttonPressed) forControlEvents:controlEvent];
}

- (void)buttonPressed {
    if (self.buttonPressBlock) {
        self.buttonPressBlock();
    }
}

#pragma mark - Appearance

-(void) setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self updateTheme];
}

-(void) setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self updateTheme];
}

-(void) setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    [self updateTheme];
}

-(void) updateTheme {
    self.layer.borderColor = _borderColor.CGColor;
    [self setTitleColor:_textColor forState:UIControlStateNormal];
    self.titleLabel.textColor = _textColor;
}

@end
