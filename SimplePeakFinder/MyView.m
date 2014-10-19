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
@property (nonatomic) CGFloat averageXPosition;
@property (nonatomic) BOOL box1;
@property (nonatomic) BOOL box2;

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


- (BOOL)_processTouchesForPeek:(NSSet *)touches {
    CGFloat sumOfYPositions = 0.0f;
    CGFloat sumOfXPositions = 0.0f;
    BOOL largeTouchFound = NO;
    for (UITouch *touch in touches) {
        sumOfYPositions += [touch locationInView:self].y;
        sumOfXPositions += [touch locationInView:self].x;
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
    if ((float)[touches count] <= 1) {
        return NO;
    }
    self.averageYPosition = sumOfYPositions/(float)[touches count];
    self.averageXPosition = sumOfXPositions/(float)[touches count];
    self.box1 = [self _inBoundingBox:touches :160 :200 :0 :350];
    self.box2 = [self _inBoundingBox:touches :380 :420 :0 :350];

    return YES;
}

- (BOOL)_inBoundingBox:(NSSet *)touches :(int)top :(int)bottom :(int)left :(int)right;
{
    int count = 0;
    for (UITouch *touch in touches) {
        if ([touch locationInView:self].y < top && [touch locationInView:self].y > bottom){
            if ([touch locationInView:self].x < right && [touch locationInView:self].x > left){
                count += 1;
            }
        }
    }
    return (count > [touches count]/4);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw a card
    CGRect rectangle1 = CGRectMake(0, 0, 350, 180);
    if (self.box1) {
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5);
        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 0.5);
    }
    else {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.5);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 0.5);
    }
    CGContextFillRect(context, rectangle1);
    
    //Draw a card
    CGRect rectangle2 = CGRectMake(0, 400, 350, 180);
    if (self.box2) {
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5);
        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 0.5);
    }
    else {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.5);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 0.5);
    }
    CGContextFillRect(context, rectangle2);

    //Draw the yPosition line
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context, 0.0f, self.averageYPosition); //start at this point
    CGContextAddLineToPoint(context, 2000.0f, self.averageYPosition); //draw to this point
    CGContextStrokePath(context);
    
    //Draw the xPosition line
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0f);
    CGContextMoveToPoint(context, self.averageXPosition, 0.0f); //start at this point
    CGContextAddLineToPoint(context, self.averageXPosition, 2000.0f); //draw to this point
    CGContextStrokePath(context);
}

@end