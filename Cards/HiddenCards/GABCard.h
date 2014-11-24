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

-(id) initWithImageNamed:(NSString *)nme;
-(void) flip;
-(void) flipUp;
-(void) flipDown;
-(void) updatePosition:(CGPoint)point;
-(void) updateHand:(BOOL)hand;
-(void) updateBoundingBox:(BOOL)hand;
-(BOOL) isCoveredByTouches:(NSSet*)touches;
-(void) coverBegan:(NSSet*)touches;
-(void) coverContinued:(NSSet*)touches;
-(void) coverEnded:(NSSet*)touches;

// implemented in subclasses

// GABOneUseCard : GABCard{}
// in coverEnded implementation
// it makes itself disappear

// in parent...
// in touchesBegan...
// for a particular card
// if([card isCoveredByTouches:touches]){
//      [card coverBegan:touches];
//}

@end
