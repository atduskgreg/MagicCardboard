//
//  GameScene.m
//  BlowParticlesDemo
//
//  Created by Greg Borenstein on 10/29/14.
//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
       
    audioRecognizer = [[ARAudioRecognizer alloc] init];
    [audioRecognizer setDelegate:self];
    [self setBackgroundColor:[UIColor blackColor]];
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"FireParticles" ofType:@"sks"];
    fireEmitter =[NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    fireEmitter.particlePosition = CGPointMake(self.size.width/2.0, self.size.height/2.0);
    [self addChild:fireEmitter];
    
    touchNodes = [[NSMutableArray alloc] init];
    
    nParticles = 100;
}

- (void)audioRecognized:(ARAudioRecognizer *)recognizer
{
//    NSLog(@"audioRecognized:");
}

- (void)audioLevelUpdated:(ARAudioRecognizer *)recognizer averagePower:(float)averagePower peakPower:(float)peakPower
{
    
    if(averagePower < -40){
        averagePower = -40;
    }
    
    float r = (40 + averagePower)/40;

    nParticles = r * 500;
    
    fireEmitter.particleBirthRate = nParticles;
    
//    NSLog(@"audioLevelUpdated: %f nParticles: %ld", averagePower, (long)nParticles);

}

- (void) clearTouchNodes
{
    [self removeChildrenInArray:touchNodes];
    [touchNodes removeAllObjects];

}

- (SKShapeNode*) cirlceNodeFromTouch:(UITouch*)touch
{
    CGRect circle = CGRectMake([touch locationInNode:self].x-25, [touch locationInNode:self].y-25, 50,50 );
    SKShapeNode *shapeNode = [[SKShapeNode alloc] init];
    shapeNode.path = [UIBezierPath bezierPathWithOvalInRect:circle].CGPath;
    shapeNode.fillColor = [SKColor redColor];
    shapeNode.lineWidth = 0;
    
    return shapeNode;
}

-(void) moveEmitterToObject:(NSSet*) touches
{
    CGFloat xPos = 0.0f;
    CGFloat yPos = 0.0f;
    
    
    for(UITouch* touch in touches){
        xPos += [touch locationInNode:self].x;
        yPos += [touch locationInNode:self].y;
    }
    
    
    xPos = xPos / touches.count;
    yPos = yPos / touches.count;
    
    xPos -= self.size.width/2.0;
    yPos -= self.size.height/2.0;
    
    yPos += 100;
    
    fireEmitter.position = CGPointMake(xPos, yPos);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self clearTouchNodes];
    
    for(UITouch* touch in [event allTouches]){
        SKShapeNode* touchNode = [self cirlceNodeFromTouch:touch];
        [self addChild:touchNode];
        [touchNodes addObject:touchNode];
    }
 
    [self moveEmitterToObject:[event allTouches]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearTouchNodes];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [self clearTouchNodes];

    for(UITouch* touch in [event allTouches]){
        SKShapeNode* touchNode = [self cirlceNodeFromTouch:touch];
        [self addChild:touchNode];
        [touchNodes addObject:touchNode];
    }
    [self moveEmitterToObject:[event allTouches]];
}

-(void)update:(CFTimeInterval)currentTime {
    NSLog(@"%f,%f", fireEmitter.position.x, fireEmitter.position.y);

}

@end
