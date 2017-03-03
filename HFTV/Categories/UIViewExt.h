/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (ViewFrameGeometry)
@property CGPoint origin;
@property CGSize size;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property CGFloat height;
@property CGFloat width;



@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

@property BOOL middle;
@property BOOL superViewMiddle;
@property BOOL shake;

- (void)shake:(UIView*)tf;

- (void)viewEnable:(BOOL)enable;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
-(UIImageView*)setBackgroundImage:(UIView*)view withImage:(UIImage*)image;
-(void)showView;
-(void)dismiss :(UIView*)view withDuration:(float)duration;


-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x withTranslation:(NSString*)string;
@end