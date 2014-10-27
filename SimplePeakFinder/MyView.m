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
@property (nonatomic) NSSet* touches;
@property (nonatomic) BOOL box1;
@property (nonatomic) BOOL box2;
@end

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Initialization code
        self.multipleTouchEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    //If the touch is not a side of hand touch, call the super method.
    if (![self _processTouchesForPeek:[event allTouches]]) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
    //If the touch is not a side of hand touch, call the super method.
    if (![self _processTouchesForPeek:[event allTouches]]) {
        [super touchesMoved:touches withEvent:event];
    }
}

//Finds the average x and y position of the touches
//@return: True if there is a touch size > 100, else False
- (BOOL)_processTouchesForPeek:(NSSet *)touches {
    CGFloat sumOfYPositions = 0.0f;
    CGFloat sumOfXPositions = 0.0f;
    BOOL largeTouchFound = NO;
    
    for (UITouch *touch in touches) {
        sumOfYPositions += [touch locationInView:self].y;
        sumOfXPositions += [touch locationInView:self].x;
        if ([touch respondsToSelector:@selector(majorRadius)]) {
            CGFloat touchSize = touch.majorRadius;
            if (touchSize > 100) {
                largeTouchFound = YES;
            }
        }
    }
    
//    if (!largeTouchFound) {
//        return NO;
//    }
    
    self.touches = touches;
    self.averageYPosition = sumOfYPositions/(float)[touches count];
    self.averageXPosition = sumOfXPositions/(float)[touches count];
    self.box1 = [self _inBoundingBox:touches :170 :190 :0 :350];
    self.box2 = [self _inBoundingBox:touches :390 :410 :0 :350];
    [self setNeedsDisplay];
    return YES;
}

//@return: True if at least 90% of the bounding box's area is covered by touches, else False
- (BOOL)_inBoundingBox:(NSSet *)touches :(float)top :(float)bottom :(float)left :(float)right;
{
    CGFloat totalPercent = 0.0f;
    CGFloat boxArea = (right-left)*(bottom-top);
    for (UITouch *touch in touches) {
        float intersection = (MIN(right, [touch locationInView:self].x + touch.majorRadius) - MAX(left, [touch locationInView:self].x - touch.majorRadius)) * (MAX(bottom, [touch locationInView:self].y - 30)-MIN(top, [touch locationInView:self].y + 30));
        totalPercent += intersection/boxArea;
    }
    NSLog(@"totalPercent : %f", totalPercent);
    return (totalPercent > 0.9);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw the top card. If the card's bounding box is activated, make the box green, else make it red.
    CGRect rectangle1 = CGRectMake(0, 0, 350, 180);
    if (self.box2) {
        CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 0.5);
        CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 0.5);
    }
    else {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.5);
        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 0.5);
    }
    CGContextFillRect(context, rectangle1);
    
    //Draw the bottom card. If the card's bounding box is activated, make the box green, else make it red.
    CGRect rectangle2 = CGRectMake(0, 400, 350, 180);
    if (self.box1) {
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