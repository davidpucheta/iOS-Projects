//
//  MyUINavigationController.h
//  ToDoManager
//
//  Created by David Reyes Pucheta on 12/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRPHandlesMOC.h"

@interface MyUINavigationController : UINavigationController <DRPHandlesMOC>

- (void) receiveMOC:(NSManagedObjectContext *)incomingMOC;

@end
