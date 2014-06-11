//
//  RFKeyboardToolbar.h
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFKeyboardToolbar : UIView

+ (instancetype)toolbarViewWithButtons:(NSArray *)buttons;

@property (nonatomic,strong) UIColor *toolbarBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *toolbarBorderColor UI_APPEARANCE_SELECTOR;

@end
