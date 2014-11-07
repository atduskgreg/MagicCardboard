//
//  GABMyScene.h
//  HiddenCards
//

//  Copyright (c) 2014 Greg Borenstein. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>

#import "GABCard.h"

@interface GABMyScene : SKScene{
    NSMutableArray* cards;
    NSMutableArray* debugTouches;
}

@end
