//
//  GameScene.m
//  WatchPong
//
//  Created by Calvin Tham on 4/4/15.
//  Copyright (c) 2015 Calvin Tham. All rights reserved.
//
#import "GameScene.h"
#define SCREENWIDTH 750
#define SCREENHEIGHT 750

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    screenWidth = screenRect.size.width;
//    screenHeight = screenRect.size.height;
    
    level = 1;
    [self setVariables];
    [sound4 playSoundForever:@"kcobble"];
    
}

-(void)lightReset
{
    [circleMarker setHidden:NO];
    [arrow setHidden:NO];
    [fish removeFromParent];
    fish = [SKSpriteNode spriteNodeWithImageNamed:@"fish"];
    [fish setZPosition:7];
    float fishR = 50;
    [fish setSize:CGSizeMake(fishR, fishR)];
    //[ball setSize:CGSizeMake(50, 50)];
    [fish setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))];
    [fish setZPosition:5];
    [fish setAlpha:0.25];
    [self addChild:fish];
    
    if(level==1)
    {
        [self addFishLevel1Movement];
        if(!tutorialDone)
            [self displayLogo:@"level1"];
    }
    else if(level==2)
    {
        [self addFishLevel2Movement];
        if(!tutorialDone)
            [self displayLogo:@"level2"];
    }
    else if(level==3)
    {
        [self addFishLevel3Movement];
        if(!tutorialDone)
            [self displayLogo:@"level3"];
    }
    
    if(tutorialDone)
    {
        [self removeTimer];
        [self beginTimer];
    }
    state = @"fishing";
}

-(void)setVariables
{
    SKSpriteNode* pond = [SKSpriteNode spriteNodeWithImageNamed:@"pond"];
    [pond setScale:2];
    [pond setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))];
    [self addChild:pond];
    
    fish = [SKSpriteNode spriteNodeWithImageNamed:@"fish"];
    [fish setZPosition:7];
    float fishR = 50;
    [fish setSize:CGSizeMake(fishR, fishR)];
    //[ball setSize:CGSizeMake(50, 50)];
    [fish setPosition:CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))];
    [fish setZPosition:5];
    [fish setAlpha:0.25];
    [self addChild:fish];
    
    if(level==1)
    {
        [self addFishLevel1Movement];
        [self displayLogo:@"level1"];
    }
    else if(level==2)
    {
        [self addFishLevel2Movement];
        [self displayLogo:@"level2"];
    }
    else if(level==3)
    {
        [self addFishLevel3Movement];
        [self displayLogo:@"level3"];
    }
    
    circleMarker = [SKSpriteNode spriteNodeWithImageNamed:@"circleMarker"];
    [circleMarker setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [circleMarker setScale:3];
    [circleMarker setZPosition:9];
    [self addChild:circleMarker];
    SKAction* fadeOut = [SKAction fadeAlphaTo:0 duration:0.2];
    SKAction* fadeIn = [SKAction fadeAlphaTo:1 duration:0.2];
    SKAction* fadeBoth = [SKAction sequence:[NSArray arrayWithObjects:fadeOut, fadeIn, nil]];
    [circleMarker runAction: [SKAction repeatActionForever:fadeBoth]];
    
    SKAction* moveDown = [SKAction moveBy:CGVectorMake(0, -50) duration:0.2];
    SKAction* moveUp = [SKAction moveBy:CGVectorMake(0, 50) duration:0.2];
    SKAction* moveBoth = [SKAction sequence:[NSArray arrayWithObjects:moveDown,moveUp, moveUp, moveDown, nil]];
    [circleMarker runAction: [SKAction repeatActionForever:moveBoth]];
    arrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow"];
    [arrow setZPosition:12];
    [self addChild:arrow];
    
    hook = [SKSpriteNode spriteNodeWithImageNamed:@"hook"];
    [self addNSNotifications];
    state = @"fishing";
    
    sound1 = [[Sound alloc] init];
    sound2 = [[Sound alloc] init];
    sound3 = [[Sound alloc] init];
    sound4 = [[Sound alloc] init];
    
    [self removeTimer];
}

-(void)timerSpriteSetup:(SKSpriteNode*)sprite
{
    [sprite setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [sprite setScale:2];
    [sprite setZPosition:12];
    [sprite setName:@"timer"];
    [self addChild:sprite];
    
    [sound3 playSound:@"win"];
}

-(void)removeTimer
{
    for(int i = 0; i < self.children.count; i++)
    {
        if([[self.children[i] name] isEqual:@"timer"])
        {
            [self.children[i] removeFromParent];
        }
    }
}
-(void)beginTimer
{
    float timePerNum = 1.5;
    SKSpriteNode* five = [SKSpriteNode spriteNodeWithImageNamed:@"5"];
    [self timerSpriteSetup:five];
    SKAction* fade = [SKAction fadeAlphaTo:0 duration:timePerNum];
    
    [five runAction:fade completion:^(void)
     {
         [five removeFromParent];
         SKSpriteNode* four = [SKSpriteNode spriteNodeWithImageNamed:@"4"];
         [self timerSpriteSetup:four];
         [four runAction:fade completion:^(void)
          {
              [four removeFromParent];
              SKSpriteNode* three = [SKSpriteNode spriteNodeWithImageNamed:@"3"];
              [self timerSpriteSetup:three];
              [three runAction:fade completion:^(void)
               {
                   [three removeFromParent];
                   SKSpriteNode* two = [SKSpriteNode spriteNodeWithImageNamed:@"2"];
                   [self timerSpriteSetup:two];
                   [two runAction:fade completion:^(void)
                    {
                        [two removeFromParent];
                        SKSpriteNode* one = [SKSpriteNode spriteNodeWithImageNamed:@"1"];
                        [self timerSpriteSetup:one];
                        [one runAction:fade completion:^(void)
                         {
                             [one removeFromParent];
                             level = 1;
                             [self lightReset];
                         }];
                    }];
               }];
          }];
     }];
    
}

-(void)addFishLevel1Movement
{
    CGPathRef circle = CGPathCreateWithEllipseInRect(CGRectMake(fish.position.x-100,fish.position.y-100,200,200), NULL);
    SKAction *followTrack;
    if(!tutorialDone)
        followTrack = [SKAction followPath:circle asOffset:NO orientToPath:YES duration:7];
    else if(tutorialDone)
        followTrack = [SKAction followPath:circle asOffset:NO orientToPath:YES duration:3.5];
    SKAction *flyincircle = [SKAction repeatActionForever:followTrack];
    [fish runAction:[SKAction repeatActionForever:flyincircle]];
}

-(void)addFishLevel2Movement
{
    CGPathRef circle = CGPathCreateWithEllipseInRect(CGRectMake(fish.position.x-400,fish.position.y-200,800,400), NULL);
    SKAction *followTrack;
    if(!tutorialDone)
        followTrack = [SKAction followPath:circle asOffset:NO orientToPath:YES duration:20];
    if(tutorialDone)
        followTrack = [SKAction followPath:circle asOffset:NO orientToPath:YES duration:10];
    
    SKAction *flyincircle = [SKAction repeatActionForever:followTrack];
    [fish runAction:[SKAction repeatActionForever:flyincircle]];
}

-(void)addFishLevel3Movement
{
    CGPathRef circle = CGPathCreateWithEllipseInRect(CGRectMake(fish.position.x-400,fish.position.y-200,800,50), NULL);
    SKAction *followTrack;
    
    if(!tutorialDone)
        followTrack = [SKAction followPath:circle asOffset:NO orientToPath:YES duration:2.5];
   if(tutorialDone)
        followTrack = [SKAction followPath:circle asOffset:NO orientToPath:YES duration:2.5];
    
    SKAction *flyincircle = [SKAction repeatActionForever:followTrack];
    [fish runAction:[SKAction repeatActionForever:flyincircle]];
}

-(void)addNSNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(press_left)
                                                 name:@"press_left"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(press_right)
                                                 name:@"press_right"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(press_cast)
                                                 name:@"press_cast"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(press_reel)
                                                 name:@"press_reel"
                                               object:nil];
}

-(void)reset
{
    [self removeAllChildren];
    level = 1;
    [self setVariables];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"HELP");
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    NSLog(@"%i", level);
    //[self moveFish];
    if([state isEqualToString:@"fishing"] || [state isEqualToString:@"hook_cast"] || [state isEqualToString:@"reeling"])
    {
        [arrow setPosition:CGPointMake(circleMarker.position.x, circleMarker.position.y - arrow.size.height/1.25)];
    }
    if([hook intersectsNode:fish] && hook.size.height < 50 && ![state isEqualToString:@"reeling"])
    {
        [sound2 playSound:@"fish_bite"];
        state = @"reeling";
        [fish removeAllActions];
        SKAction* rotateToFaceHook = [SKAction rotateToAngle:1 duration:0.1];
        [fish runAction:rotateToFaceHook];
        SKAction* rotateRight = [SKAction rotateByAngle:0.25 duration:0.05];
        SKAction* rotateLeft = [SKAction rotateByAngle:-0.25 duration:0.05];
        SKAction* sequence = [SKAction sequence:[NSArray arrayWithObjects:rotateRight, rotateLeft, rotateLeft, rotateRight, nil]];
        [fish runAction:[SKAction repeatActionForever:sequence]];
        
        [circleMarker setHidden:YES];
        [arrow setHidden:YES];
    }
    
    if([state isEqualToString:@"reeling"])
    {
        
        SKAction* moveToHook = [SKAction moveTo:hook.position duration:0.1];
        [fish runAction:moveToHook];
        
        if(abs(fish.position.x - CGRectGetMidX(self.frame)) < 100)
        {
            if(fish.position.y < 100)
            {
                state = @"win";
            }
        }
    }
    
    if([state isEqualToString:@"hook_cast"] || [state isEqualToString:@"reeling"])
    {
        [self beginNewLine:CGPointMake(CGRectGetMidX(self.frame), 0)];
        [self addPointToLine:CGPointMake(hook.position.x, hook.position.y)];
    }
    
    if([state isEqualToString:@"win"])
    {
        if(level < 3)
        {
            level++;
            [self lightReset];
            [sound2 playSound:@"win"];
        }
        else if(tutorialDone==NO)
        {
            level = 1;
            tutorialDone = YES;
            [self lightReset];
            [sound2 playSound:@"win"];
        }
        else if(!beatTheGame)
        {
            [self removeAllChildren];
            SKSpriteNode* winImage = [SKSpriteNode spriteNodeWithImageNamed:@"win"];
            [winImage setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
            [winImage setScale:2];
            [winImage setZPosition:13];
            [self addChild:winImage];
            [self removeTimer];
            [sound4 playSoundForever:@"alecisthearsonist"];
            beatTheGame = YES;
        }
        
    }
}

-(int)genRandNum :(int)min :(int)max
{
    int randNum = min + arc4random_uniform(max - min + 1);
    return randNum;
}

-(void)press_left
{
    [circleMarker setHidden:NO];
    [arrow setHidden:NO];
    
    if(circleMarker.position.x<50)
        return;
    //SKAction* moveLeft = [SKAction moveBy:CGVectorMake(-50, 0) duration:0.1];
    //[circleMarker runAction:moveLeft];
    [sound2 playSound:@"move_circle"];
    [circleMarker setPosition:CGPointMake(circleMarker.position.x- 75, circleMarker.position.y)];
}

-(void)press_right
{
    [circleMarker setHidden:NO];
    [arrow setHidden:NO];
    
    if(circleMarker.position.x>1000)
        return;
    //SKAction* moveRight = [SKAction moveBy:CGVectorMake(50, 0) duration:0.1];
    //[circleMarker runAction:moveRight];
    [sound2 playSound:@"move_circle"];
    [circleMarker setPosition:CGPointMake(circleMarker.position.x+ 75, circleMarker.position.y)];
}

-(void)press_cast
{
    //shoot hook
    hook = [SKSpriteNode spriteNodeWithImageNamed:@"hook"];
    [hook setName:@"hook"];
    [self addChild:hook];
    
    float halfwayDistanceX = (circleMarker.position.x + SCREENWIDTH/2)/2;
    float halfwayDistanceY = circleMarker.position.y/2;
    SKAction* moveToHalfWayBtwnMarker = [SKAction moveTo:CGPointMake(halfwayDistanceX, halfwayDistanceY) duration:0.05];
    SKAction* getBigger = [SKAction resizeByWidth:500 height:500 duration:0.15];
    SKAction* moveToMarker = [SKAction moveTo:circleMarker.position duration:0.2];
    SKAction* getSmaller = [SKAction resizeToWidth:25 height:25 duration:0.75];
    SKAction* first = [SKAction group:[NSArray arrayWithObjects:moveToHalfWayBtwnMarker, getBigger, nil] ];
    SKAction* second = [SKAction group:[NSArray arrayWithObjects:moveToMarker, getSmaller, nil]];
    SKAction* all = [SKAction sequence:[NSArray arrayWithObjects:first, second, nil]];
    [hook runAction:all completion:^(void){
                [sound1 playSound:@"hook_splash2"];
                }];
    state = @"hook_cast";
    [sound1 playSound:@"throw_hook"];
}

-(void)press_reel
{
    if([state isEqualToString:@"fishing"])
        return;
    
    SKAction* moveToShip = [SKAction moveTo:CGPointMake(CGRectGetMidX(self.frame), 0) duration:0.5];
    [hook runAction:moveToShip];
    [sound1 playSound:@"reeling"];
    
}

-(void)displayLogo :(NSString*)logoName
{
    SKSpriteNode* logo = [SKSpriteNode spriteNodeWithImageNamed:logoName];
    [logo setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [logo setScale:2];
    [logo setZPosition:12];
    [self addChild:logo];
    
    SKAction* fade = [SKAction fadeAlphaTo:0 duration:1.5];
    
    [logo runAction:fade completion:^(void){
        [logo removeFromParent];
    }];
}

-(void)beginNewLine:(CGPoint)startPt
{
    SKShapeNode *line = [SKShapeNode node];
    [line setZPosition:8];
    CGMutablePathRef pathToDraw = CGPathCreateMutable();
    CGPathMoveToPoint(pathToDraw, NULL, startPt.x, startPt.y);
    line.path = pathToDraw;
    
    UIColor *orangish = [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0 alpha:1];
    
    //random color generator
    //UIColor *orangish = [UIColor colorWithRed:(arc4random() %256)/255.0 green:(arc4random() %256)/255.0 blue:(arc4random() %256)/255.0 alpha:1];
    [line setStrokeColor:orangish];
    [line setFillColor:orangish];
    [line setGlowWidth:0];
    [line setLineWidth:10.0];
    [line setLineCap:kCGLineCapSquare];
    [line setLineJoin:kCGLineJoinBevel];
    [currentLine removeFromParent];
    currentLine = line;
    currentPathToDraw = pathToDraw;
    [self addChild:line];
}

-(void)addPointToLine:(CGPoint)pt
{
    CGPathAddLineToPoint(currentPathToDraw, NULL, pt.x, pt.y);
    CGPathMoveToPoint(currentPathToDraw, NULL, pt.x, pt.y);
    currentLine.path = currentPathToDraw;
}

-(void)moveFish
{
    [fish setPosition:CGPointMake(fish.position.x + fishHV, fish.position.y + fishVV)];
    NSLog(@"width: %f %f",fish.position.x, fish.position.y);
    
    if(fish.position.x > SCREENWIDTH-fish.size.width)
    {
        fishHV*=-1;
    }
    if(fish.position.x < 300)
    {
        fishHV*=-1;
    }
    if(fish.position.y > SCREENHEIGHT - fish.size.height/2)
    {
        fishVV*=-1;
    }
    if(fish.position.y < 0 + fish.size.width/2)
    {
        fishVV*=-1;
    }
}
@end
