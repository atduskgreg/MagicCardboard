//
//  GABCard.h
//  HiddenCards
//
//  Created by Greg Borenstein on 9/1/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GABCard : SKSpriteNode{
    SKTexture* backTexture;
    SKTexture* frontTexture;
    BOOL faceUp;
    BOOL sideOfHand;
    BOOL inBoundingBox;
    SKLabelNode* debugLabel;
}
-(id) initWithImageNamed:(NSString *)name;
-(void) flip;
-(void) updatePosition:(CGPoint)point;
-(void) updateHand:(BOOL)hand;
-(void) updateBoundingBox:(BOOL)hand;
-(BOOL) inBoundingBox;

@end
