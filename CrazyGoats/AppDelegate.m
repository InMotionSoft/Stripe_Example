//
//  AppDelegate.m
//  CrazyGoats
//
//  Created by Max on 06.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "AppDelegate.h"

@import Stripe;
@import SVProgressHUD;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Stripe setDefaultPublishableKey:kStripePublishKey];
    
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleDark)];
    return YES;
}

@end
