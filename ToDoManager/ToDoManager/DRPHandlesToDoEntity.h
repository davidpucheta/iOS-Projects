//
//  DRPHandlesToDoEntity.h
//  ToDoManager
//
//  Created by David Reyes Pucheta on 12/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoEntity.h"

@protocol DRPHandlesToDoEntity <NSObject>

- (void) receiveToDoEntity:(ToDoEntity *) incomingToDoEntity;

@end
