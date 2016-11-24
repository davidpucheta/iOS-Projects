//
//  DRPHandlesMOC.h
//  ToDoManager
//
//  Created by David Reyes Pucheta on 12/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DRPHandlesMOC <NSObject>

- (void) receiveMOC:(NSManagedObjectContext *) incomingMOC;

@end
