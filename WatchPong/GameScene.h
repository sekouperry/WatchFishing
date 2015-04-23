//
//  GameScene.h
//  WatchPong
//

//  Copyright (c) 2015 Calvin Tham. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Sound.h"

@interface GameScene : SKScene
{
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    SKSpriteNode* fish;
    float fishHV;
    float fishVV;
    
    SKSpriteNode* circleMarker;
    SKSpriteNode* hook;
    SKShapeNode* currentLine;
    CGMutablePathRef currentPathToDraw;
    
    NSString* state; //fishing reeling win lose
    
    Sound* sound1;
    Sound* sound2;
    Sound* sound3;
    Sound* sound4;
    
    SKSpriteNode* arrow;
    int level; //1 2 3
    
    bool tutorialDone;
}
@end
