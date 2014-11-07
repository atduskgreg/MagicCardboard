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
    self.size = CGSizeMake(137.5, 192.5);
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
    NSLog(@"The value of integer num is %lu", (unsigned long)[touches count]);
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
        if (inBoundingBox){
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

// TODO: Implement this method.
- (BOOL)inBoundingBox:(NSSet *)touches {
    return YES;
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
