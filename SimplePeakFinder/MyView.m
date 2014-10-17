//
//  MyView.m
//  SimpleSingleTouch
//
//  Created by Jessica Qian on 9/27/14.
//  Copyright (c) 2014 Jessica Qian. All rights reserved.
//

#import "MyView.h"

@interface MyView()
@property (nonatomic) CGFloat averageYPosition;
@end

@implementation MyView

@synthesize averageYPosition = _averageYPosition;

- (void)setAverageYPosition:(CGFloat)averageYPosition
{
    _averageYPosition = averageYPosition;
    [self setNeedsDisplay]; //Reset the display

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    if (![self _processTouchesForPeek:touches]) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
    if (![self _processTouchesForPeek:touches]) {
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [super touchesCancelled:touches withEvent:event];
}


- (BOOL)_processTouchesForPeek:(NSSet *)touches;
{
    CGFloat sumOfYPositions = 0.0f;
    BOOL largeTouchFound = NO;
    
    for (UITouch *touch in touches) {
        sumOfYPositions += [touch locationInView:self].y;
        if ([touch respondsToSelector:@selector(majorRadius)]) {
            CGFloat touchSize = touch.majorRadius;
            if (touchSize > 10) {
                largeTouchFound = YES;
            }
        }
    }
    if (!largeTouchFound) {
        return NO;
    }
    self.averageYPosition = sumOfYPositions/(float)[touches count];
    return YES;
}

//Draw a line at averageYPosition
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Draw a UIBezier path
    CGContextSetStrokeColorWithColor(context, [[UIColor blueColor] CGColor]);
    UIBezierPath *blueHalf = [UIBezierPath bezierPath];
    [blueHalf addArcWithCenter:CGPointMake(150, 200) radius:130.0 startAngle:M_PI+0.5 endAngle:-0.5 clockwise:YES];
    [blueHalf setLineWidth:4.0];
    [blueHalf stroke];
    //Draw a card
    CGRect rectangle = CGRectMake(25, 180, 250, 300);
    if (self.averageYPosition > 50 && self.averageYPosition < 150) {
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5);
        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 0.5);
    }
    else {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.5);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 0.5);
    }
    CGContextFillRect(context, rectangle);

    //Draw the yposition line
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context, 0.0f, self.averageYPosition); //start at this point
    CGContextAddLineToPoint(context, 2000.0f, self.averageYPosition); //draw to this point
    CGContextStrokePath(context);
}

@end