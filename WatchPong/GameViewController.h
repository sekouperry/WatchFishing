//
//  GameViewController.h
//  WatchPong
//

//  Copyright (c) 2015 Calvin Tham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface GameViewController : UIViewController
{
    __weak IBOutlet UIButton *controlsButton;
    __weak IBOutlet UIButton *lButton;
    __weak IBOutlet UIButton *rButton;
    __weak IBOutlet UIButton *reelButton;
    __weak IBOutlet UIButton *castButton;
}
@end
