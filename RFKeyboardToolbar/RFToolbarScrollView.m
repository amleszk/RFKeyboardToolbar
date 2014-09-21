
#import "RFToolbarScrollView.h"

@implementation RFToolbarScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.showsHorizontalScrollIndicator = NO;
        self.contentInset = UIEdgeInsetsMake(6.0f, 0.0f, 8.0f, 6.0f);
        self.canCancelContentTouches = YES;
    }
    return self;
}

-(BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}

@end
