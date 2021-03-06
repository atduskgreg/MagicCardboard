//
//  GameScene.h
//  BlowParticlesDemo
//

//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ARAudioRecognizer.h"
#import "ARAudioRecognizerDelegate.h"

@interface GameScene : SKScene<ARAudioRecognizerDelegate>{
    ARAudioRecognizer* audioRecognizer;
    UIColor* backgroundColor;
    SKEmitterNode* fireEmitter;
    NSInteger nParticles;
    
    
    NSMutableArray* touchNodes;
}

- (void)audioRecognized:(ARAudioRecognizer *)recognizer;
- (void)audioLevelUpdated:(ARAudioRecognizer *)recognizer averagePower:(float)averagePower peakPower:(float)peakPower;

- (void) clearTouchNodes;

- (SKShapeNode*) cirlceNodeFromTouch:(UITouch*)touch;

-(void) moveEmitterToObject:(NSSet*) touches;

@end
