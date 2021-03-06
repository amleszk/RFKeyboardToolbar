//
//  RFKeyboardToolbar.m
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import "RFKeyboardToolbar.h"
#import "RFToolbarButton.h"
#import "RFToolbarScrollView.h"

@interface RFKeyboardToolbar ()

#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
@property (nonatomic,strong) UIVisualEffectView *toolbarVisualEffectView;
@property (nonatomic) BOOL canUseVisualEffectView;
#endif

@property (nonatomic,strong) UIView *toolbarView;

@property (nonatomic,strong) RFToolbarScrollView *scrollView;
@property (nonatomic,strong) CALayer *topBorder;
@property (nonatomic,strong) NSArray *buttonsToAdd;


@end

@implementation RFKeyboardToolbar

@synthesize toolbarBackgroundColor = _toolbarBackgroundColorInternal;
@synthesize toolbarBorderColor = _toolbarBorderColorInternal;

-(void) commonInitWithButtons:(NSArray *)buttons {
#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    _canUseVisualEffectView = (NSClassFromString (@"UIVisualEffectView") != nil);
#endif
    _buttonsToAdd = buttons;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:[self createInputAccessoryView]];
    
    [self updateTheme];
}

+ (instancetype)toolbarViewWithButtons:(NSArray *)buttons {
    return [[RFKeyboardToolbar alloc] initWithButtons:buttons];
}

- (id)initWithButtons:(NSArray*)buttons {
    self = [super initWithFrame:CGRectMake(0, 0, self.window.rootViewController.view.bounds.size.width, 40)];
    if (self) {

#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        _blurEffectStyle = UIBlurEffectStyleLight;
#endif
        
        [self commonInitWithButtons:buttons];
    }
    return self;
}

#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0

+ (instancetype)toolbarViewWithBlurEffectStyle:(UIBlurEffectStyle)blurEffectStyle buttons:(NSArray *)buttons {
    return [[RFKeyboardToolbar alloc] initWithBlurEffectStyle:blurEffectStyle buttons:buttons];
}

- (id)initWithBlurEffectStyle:(UIBlurEffectStyle)blurEffectStyle buttons:(NSArray *)buttons {
    self = [super initWithFrame:CGRectMake(0, 0, self.window.rootViewController.view.bounds.size.width, 40)];
    if (self) {
        _blurEffectStyle = blurEffectStyle;
        [self commonInitWithButtons:buttons];
    }
    return self;
}

#endif

#pragma mark - UIView overrides

- (void)layoutSubviews {
    CGRect frame = _toolbarView.bounds;
    frame.size.height = 0.5f;
    
    _topBorder.frame = frame;
}

-(void) willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        [self updateTheme];
    }
}

#pragma mark - UIView creation

- (UIView*)createInputAccessoryView {
    CGRect toolbarViewFrame = CGRectMake(0, 0, self.bounds.size.width, 40);
    _toolbarView = [[UIView alloc] initWithFrame:toolbarViewFrame];
    _toolbarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _topBorder = [CALayer layer];
    _topBorder.frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, 0.5f);
    [_toolbarView.layer addSublayer:_topBorder];
    [_toolbarView addSubview:[self createToolbarScrollView]];

    [self updateTheme];
    
#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    if ([_useBlurEffect boolValue] && _canUseVisualEffectView) {
        _toolbarVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:_blurEffectStyle]];
        _toolbarVisualEffectView.frame = toolbarViewFrame;
        _toolbarVisualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_toolbarVisualEffectView.contentView addSubview:_toolbarView];
        return _toolbarVisualEffectView;
    }
    else
#endif
        
    {
        return _toolbarView;
    }
}

- (UIScrollView*)createToolbarScrollView {
    _scrollView = [[RFToolbarScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    
    NSUInteger index = 0;
    NSUInteger originX = 8;
    
    CGRect originFrame;
    
    for (RFToolbarButton *eachButton in _buttonsToAdd) {
        originFrame = CGRectMake(originX, 0, eachButton.frame.size.width, eachButton.frame.size.height);
        eachButton.frame = originFrame;
        
        [_scrollView addSubview:eachButton];
        
        originX = originX + eachButton.bounds.size.width + 8;
        index++;
    }
    
    CGSize contentSize = _scrollView.contentSize;
    contentSize.width = originX - 8;
    _scrollView.contentSize = contentSize;
    
    return _scrollView;
}

#pragma mark Appearance

- (UIColor *)toolbarBorderColor {
    if(_toolbarBorderColorInternal == nil) {
        _toolbarBorderColorInternal = [[[self class] appearance] toolbarBorderColor];
    }
    
    if(_toolbarBorderColorInternal != nil) {
        return _toolbarBorderColorInternal;
    }
    
    return [UIColor colorWithWhite:0.678 alpha:1.0];
}

- (UIColor *)toolbarBackgroundColor {
    if(_toolbarBackgroundColorInternal == nil) {
        _toolbarBackgroundColorInternal = [[[self class] appearance] toolbarBackgroundColor];
    }
    
    if(_toolbarBackgroundColorInternal != nil) {
        return _toolbarBackgroundColorInternal;
    }
    
    return [UIColor colorWithWhite:0.973 alpha:1.0];
}


#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
-(void) setBlurEffectStyle:(UIBlurEffectStyle)blurEffectStyle {
    _blurEffectStyle = blurEffectStyle;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview:[self createInputAccessoryView]];
}

-(void) setUseBlurEffect:(NSNumber *)useBlurEffect {
    _useBlurEffect = useBlurEffect;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview:[self createInputAccessoryView]];
}

#endif

-(void) updateTheme {
    if (![_useBlurEffect boolValue] || !_canUseVisualEffectView)
    {
        _toolbarView.backgroundColor = self.toolbarBackgroundColor;
    }
    
    _topBorder.backgroundColor = self.toolbarBorderColor.CGColor;
}

@end
