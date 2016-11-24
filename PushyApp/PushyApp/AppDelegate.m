//
//  AppDelegate.m
//  PushyApp
//
//  Created by David Reyes Pucheta on 17/11/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    application.applicationIconBadgeNumber = 0;
    
    UILocalNotification *localNotif = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if(localNotif){
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Received while in backgorund" message:localNotif.alertBody preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *aa = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        
        [ac addAction:aa];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [application.keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
        });

    }
    
    return YES;
}

- (void) application:(UIApplication *)application didReceiveLocalNotification:(nonnull UILocalNotification *)notification{
    
    application.applicationIconBadgeNumber = 0;
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Received while in foreground" message:notification.alertBody preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [ac addAction:aa];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [application.keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    });

    
}

- (void) application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    
    application.applicationIconBadgeNumber = 0;
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Received on action" message:identifier preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    
    [ac addAction:aa];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [application.keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
    });
    
    completionHandler();
}

@end
