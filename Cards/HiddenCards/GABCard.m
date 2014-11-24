//
//  GABCard.m
//  HiddenCards
//
//  Created by Greg Borenstein on 9/1/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GABCard.h"

@implementation GABCard

-(id) initWithImageNamed:(NSString *)name
{
    frontTexture = [SKTexture textureWithImageNamed:name];
    backTexture = [SKTexture textureWithImageNamed:@"card_back"];
    self = [super initWithTexture:backTexture];
    self.size = CGSizeMake(175, 250);
    self.name = @"card";
    
    super.userInteractionEnabled = TRUE;

    faceUp  = false;
    sideOfHand = false;
    inBoundingBox = false;
    return self;
}

-(void) updatePosition:(CGPoint)point
{
    super.position = point;
}

-(void) updateHand:(BOOL)hand
{
    sideOfHand = hand;
}

-(void) updateBoundingBox:(BOOL)box
{
    inBoundingBox = box;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//NSLog(@"The value of integer num is %lu", (unsigned long)[touches count]);
    if (!sideOfHand){
        if (!faceUp){
            for (UITouch* touch in touches){
                CGPoint location = [touch locationInNode:self.parent];
                SKNode* touchedNode = [self nodeAtPoint:location];
                [(GABCard*)touchedNode updatePosition:location];
            }
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch* touch in touches){
        if (touch.tapCount > 1){
                [self flip];
        } else {
            self.zPosition = 15;
            [self runAction:[SKAction scaleTo:1.2 duration:0.2]];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* touch in touches) {
        self.zPosition = 0;
        [self runAction:[SKAction scaleTo:1.0 duration:0.1]];
    }
}

- (BOOL)isCoveredByTouches:(NSSet *)touches {
    float top = self.size.height;
    float bottom = self.size.height/2;
    float left = -self.size.width/2;
    float right = self.size.width/2;
    for (UITouch *touch in touches){
        float y = [touch locationInNode:self].y;
        float x = [touch locationInNode:self].x;
        if ([touch locationInNode:self].y < top && [touch locationInNode:self].y > bottom && [touch locationInNode:self].x > left && [touch locationInNode:self].x < right) {
            NSLog(@"y position : %f", y);
            NSLog(@"x position : %f", x);
            NSLog(@"top : %f", top);
            NSLog(@"bottom : %f", bottom);
            NSLog(@"left : %f", left);
            NSLog(@"right : %f", right);
            return true;
        }
    }
    return false;
}

- (void)coverBegan:(NSSet *)touches {
    if ([self isCoveredByTouches:touches]) {
        [self flipUp];
    } else {
        [self flipDown];
    }
}

- (void)coverContinued:(NSSet *)touches {
    if ([self isCoveredByTouches:touches]) {
        [self flipUp];
    } else {
        [self flipDown];
    }
}

- (void)coverEnded:(NSSet *)touches {
    [self flipDown];
}

-(void) flipUp
{
    faceUp = true;
    self.texture = frontTexture;
}

-(void) flipDown
{
    faceUp = false;
    self.texture = backTexture;
}

-(void) flip
{
    faceUp = !faceUp;
    if(faceUp){
        self.texture = frontTexture;
    } else {
        self.texture = backTexture;
    
    }
}
    
@end