//
//  LAppDelegate.h
//  life
//
//  Created by Kemal Enver on 12/10/2012.
//  Copyright (c) 2012 Kemal Enver. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LViewController;

@interface LAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LViewController *viewController;

@end
