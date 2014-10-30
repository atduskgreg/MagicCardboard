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
    nParticles = 100;
}

- (void)audioRecognized:(ARAudioRecognizer *)recognizer
{
    NSLog(@"audioRecognized:");
}

- (void)audioLevelUpdated:(ARAudioRecognizer *)recognizer averagePower:(float)averagePower peakPower:(float)peakPower
{
 
    
    if(averagePower < -40){
        averagePower = -40;
    }
    
    float r = (40 + averagePower)/40;

    nParticles = r * 500;
    
    fireEmitter.particleBirthRate = nParticles;
    
    NSLog(@"audioLevelUpdated: %f nParticles: %ld", averagePower, (long)nParticles);

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

}

@end
