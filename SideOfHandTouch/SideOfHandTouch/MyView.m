//
//  MyView.m
//  SimpleSingleTouch
//
//  Created by Jessica Qian on 9/27/14.
//  Copyright (c) 2014 Jessica Qian. All rights reserved.
//

#import "MyView.h"

@interface MyView()
@property (nonatomic) NSSet* touches;

@end

@implementation MyView
//@synthesize touches = _touches;
//
//- (void)setTouches:(NSSet*)touches
//{
//    _touches = touches;
//    [self setNeedsDisplay]; //Reset the display
//    
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = YES;
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    self.touches = [event allTouches];
    [self setNeedsDisplay];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
    self.touches = [event allTouches];
    [super touchesMoved:touches withEvent:event];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    [[UIColor redColor] set];
    for (UITouch *touch in self.touches)
    {
        CGContextAddArc(context, [touch locationInView:self].x, [touch locationInView:self].y, touch.majorRadius, 0.0, M_PI * 2.0, YES);
        CGContextStrokePath(context);
    }
}

@end
