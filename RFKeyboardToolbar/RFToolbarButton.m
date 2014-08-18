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

@synthesize textColor=_textColorInternal;
@synthesize buttonBorderColor=_buttonBorderColorInternal;

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
        [self setTitleColor:self.textColor forState:UIControlStateNormal];
        
        self.backgroundColor = [self apperanceBackgroundColor];
        self.layer.borderColor = self.buttonBorderColor.CGColor;
        self.titleLabel.textColor = self.textColor;
    }
    return self;
}

- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent {
    self.buttonPressBlock = eventHandler;
    [self addTarget:self action:@selector(buttonPressed) forControlEvents:controlEvent];
}

- (void)buttonPressed {
    if (self.buttonPressBlock) {
        self.buttonPressBlock(self);
    }
}

#pragma mark - Appearance

- (UIColor *)buttonBorderColor {
    if(_buttonBorderColorInternal == nil) {
        _buttonBorderColorInternal = [[[self class] appearance] buttonBorderColor];
    }
    
    if(_buttonBorderColorInternal != nil) {
        return _buttonBorderColorInternal;
    }
    
    return [UIColor colorWithWhite:0.8 alpha:1.0];
}

- (UIColor *)textColor {
    if(_textColorInternal == nil) {
        _textColorInternal = [[[self class] appearance] textColor];
    }
    
    if(_textColorInternal != nil) {
        return _textColorInternal;
    }
    
    return [UIColor colorWithWhite:0.500 alpha:1.0];
}

- (UIColor *)apperanceBackgroundColor {
    UIColor *apperanceBackgroundColor = [[[self class] appearance] backgroundColor];
    
    if(apperanceBackgroundColor != nil) {
        return apperanceBackgroundColor;
    }
    
    return [UIColor colorWithWhite:0.902 alpha:1.0];
}

@end
