//
//  RFKeyboardToolbar.h
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFKeyboardToolbar : UIView <UIAppearanceContainer>

+ (instancetype)toolbarViewWithButtons:(NSArray *)buttons;

//Ignored for iOS8, uses blur visual effect instead
@property (nonatomic,strong) UIColor *toolbarBackgroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic,strong) UIColor *toolbarBorderColor UI_APPEARANCE_SELECTOR;

#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0

+ (instancetype)toolbarViewWithBlurEffectStyle:(UIBlurEffectStyle)blurEffectStyle buttons:(NSArray *)buttons;

@property (nonatomic) UIBlurEffectStyle blurEffectStyle UI_APPEARANCE_SELECTOR;
#endif

@end
