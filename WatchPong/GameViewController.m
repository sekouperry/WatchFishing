//
//  GameViewController.m
//  WatchPong
//
//  Created by Calvin Tham on 4/4/15.
//  Copyright (c) 2015 Calvin Tham. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    [self setButtonsHidden:YES];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)setButtonsHidden:(bool)onOrOff
{
    [lButton setHidden:onOrOff];
    [rButton setHidden:onOrOff];
    [reelButton setHidden:onOrOff];
    [castButton setHidden:onOrOff];
}
- (IBAction)changeControls:(id)sender {
    if([reelButton isHidden])
    {
        [controlsButton setTitle:@"ON PHONE" forState:UIControlStateNormal];
        [self setButtonsHidden:NO];
    }
    else
    {
        [controlsButton setTitle:@"ON WATCH" forState:UIControlStateNormal];
        [self setButtonsHidden:YES];
    }

}
- (IBAction)castButtonPress:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"press_cast"
     object:self];

}
- (IBAction)reelButtonPress:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"press_reel"
     object:self];

}
- (IBAction)lButtonPress:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"press_left"
     object:self];

}
- (IBAction)rButtonPress:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"press_right"
     object:self];

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
