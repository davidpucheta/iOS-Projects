//
//  ToDoEntity+CoreDataProperties.h
//  tableViewPlusCD
//
//  Created by David Reyes Pucheta on 11/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
