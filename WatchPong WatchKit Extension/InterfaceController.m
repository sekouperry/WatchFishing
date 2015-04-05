//
//  InterfaceController.m
//  WatchPong WatchKit Extension
//
//  Created by Calvin Tham on 4/4/15.
//  Copyright (c) 2015 Calvin Tham. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
- (IBAction)lPress {
    NSLog(@"PRESSED L");
    [WKInterfaceController openParentApplication:@{@"press" : @"left"} reply:^(NSDictionary *replyInfo, NSError *error) {
        if (error) {
            NSLog(@"Error from parent: %@", error);
        } else {
            //do something with the reply info....
        }
    }];
}
- (IBAction)rPress {
    [WKInterfaceController openParentApplication:@{@"press" : @"right"} reply:^(NSDictionary *replyInfo, NSError *error) {
        if (error) {
            NSLog(@"Error from parent: %@", error);
        } else {
            //do something with the reply info....
        }
    }];
}
- (IBAction)castPress {
    [WKInterfaceController openParentApplication:@{@"press" : @"cast"} reply:^(NSDictionary *replyInfo, NSError *error) {
        if (error) {
            NSLog(@"Error from parent: %@", error);
        } else {
            //do something with the reply info....
        }
    }];
}
- (IBAction)reelPress {
    [WKInterfaceController openParentApplication:@{@"press" : @"reel"} reply:^(NSDictionary *replyInfo, NSError *error) {
        if (error) {
            NSLog(@"Error from parent: %@", error);
        } else {
            //do something with the reply info....
        }
    }];
}

@end



