//
//  MyUIViewController.h
//  ToDoManager
//
//  Created by David Reyes Pucheta on 12/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRPHandlesMOC.h"
#import "DRPHandlesToDoEntity.h"
//#import "ToDoEntity.h"

@interface MyUIViewController : UIViewController <DRPHandlesMOC, DRPHandlesToDoEntity>

- (void) receiveMOC:(NSManagedObjectContext *)incomingMOC;

- (void) receiveToDoEntity:(ToDoEntity *) incomingToDoEntity;


@end
