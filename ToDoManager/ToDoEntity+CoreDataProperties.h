//
//  ToDoEntity+CoreDataProperties.h
//  ToDoManager
//
//  Created by David Reyes Pucheta on 15/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *toDoDetails;
@property (nullable, nonatomic, retain) NSDate *toDoDueDate;
@property (nullable, nonatomic, retain) NSString *toDoTitle;
@property (nullable, nonatomic, retain) NSString *toDoLocation;
@property (nullable, nonatomic, retain) NSString *toDoTag;

@end

NS_ASSUME_NONNULL_END
