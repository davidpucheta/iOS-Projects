//
//  ViewController.m
//  PushyApp
//
//  Created by David Reyes Pucheta on 17/11/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (void) requestPermissionToNotify;
- (void) createANotification:(int)secondsInTheFuture;

@end

@implementation ViewController

- (IBAction)scheduleTapped:(id)sender {
    [self requestPermissionToNotify];
    [self createANotification:15];
}

- (void) requestPermissionToNotify{
    
    UIMutableUserNotificationAction *floatAction = [[UIMutableUserNotificationAction alloc] init];
    floatAction.identifier = @"FLOAT_ACTION";
    floatAction.title = @"Float";
    floatAction.activationMode = UIUserNotificationActivationModeBackground;
    floatAction.destructive = YES;
    floatAction.authenticationRequired = NO;
    
    UIMutableUserNotificationAction *stingAction = [[UIMutableUserNotificationAction alloc] init];
    stingAction.identifier = @"STING_ACTION";
    stingAction.title = @"Sting";
    stingAction.activationMode = UIUserNotificationActivationModeForeground;
    stingAction.destructive = NO;
    stingAction.authenticationRequired = NO;
    
    UIMutableUserNotificationCategory *responseCategory = [[UIMutableUserNotificationCategory alloc] init];
    responseCategory.identifier = @"MAIN_CATEGORY";
    [responseCategory setActions:@[stingAction,floatAction] forContext:UIUserNotificationActionContextDefault];
    
    NSSet *categories = [NSSet setWithObjects:responseCategory, nil];
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

- (void) createANotification:(int)secondsInTheFuture{
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:secondsInTheFuture];
    localNotif.timeZone = nil;
    
    localNotif.alertTitle = @"Alert Title";
    localNotif.alertBody = @"Alert Body";
    localNotif.alertAction = @"okay";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    
    localNotif.applicationIconBadgeNumber = 123;
    
    localNotif.category = @"MAIN_CATEGORY";
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
