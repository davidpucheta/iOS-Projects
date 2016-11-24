//
//  AppDelegate.h
//  CoreDataApp
//
//  Created by David Reyes Pucheta on 26/11/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ChoreMO.h"
#import "PersonMO.h"
#import "ChoreLogMO.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (ChoreMO *) CreateChoreMO ;
- (PersonMO *) CreatePersonMO ;
- (ChoreLogMO *) CreateChoreLogMO;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

