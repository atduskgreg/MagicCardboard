//
//  GABMyScene.m
//  HiddenCards
//
//  Created by Greg Borenstein on 9/1/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GABMyScene.h"

@implementation GABMyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        cards = [[NSMutableArray alloc]init];
        
        GABCard *card = [[GABCard alloc ] initWithImageNamed:@"putin_card"];
        card.position = CGPointMake(200,400);
        [self addChild:card];
        
        [cards addObject:card];
        
        GABCard *card2 = [[GABCard alloc ] initWithImageNamed:@"putin_card"];
        card2.position = CGPointMake(300,400);
        [self addChild:card2];
        [cards addObject:card2];
        
        self.name = @"background";
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    NSSet *location;
    if ([self sideOfHandTouch:[event allTouches]]) {
        for (GABCard *card in cards){
            [card coverBegan:[event allTouches]];
        }
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
    if ([self sideOfHandTouch:[event allTouches]]) {
        for (GABCard *card in cards){
            [card coverContinued:[event allTouches]];
        }
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    for (GABCard *card in cards){
        [card coverEnded:[event allTouches]];
    }
    [super touchesMoved:touches withEvent:event];
}

// @return: True if there is a touch size > 100, else False
- (BOOL)sideOfHandTouch:(NSSet *)touches {
    BOOL largeTouchFound = NO;
    
    for (UITouch *touch in touches) {
        if ([touch respondsToSelector:@selector(majorRadius)]) {
            CGFloat touchSize = touch.majorRadius;
            if (touchSize > 100) {
                largeTouchFound = YES;
            }
        }
    }
    return largeTouchFound;
}

@end