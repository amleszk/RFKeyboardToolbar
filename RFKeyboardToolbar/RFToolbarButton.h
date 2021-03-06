//
//  RFToolbarButton.h
//
//  Created by Rex Finn on 12/3/13.
//  Copyright (c) 2013 Rex Finn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^eventHandlerBlock)(id sender);

@interface RFToolbarButton : UIButton <UIAppearanceContainer>

+ (instancetype)buttonWithTitle:(NSString *)title;

- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent;

@property (nonatomic,strong) UIColor *buttonBorderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *textColor UI_APPEARANCE_SELECTOR;

@end
