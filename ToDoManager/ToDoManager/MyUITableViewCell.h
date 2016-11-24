//
//  MyUITableViewCell.h
//  ToDoManager
//
//  Created by David Reyes Pucheta on 12/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity.h"

@interface MyUITableViewCell : UITableViewCell

@property (strong, nonatomic) ToDoEntity *localToDoEntity;

@property (weak, nonatomic) IBOutlet UILabel *toDoTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *toDoDueDateLabel;


- (void) setInternalFields:(ToDoEntity *) incomingToDoEntity;

@end
