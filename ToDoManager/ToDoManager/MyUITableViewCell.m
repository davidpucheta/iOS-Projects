//
//  MyUITableViewCell.m
//  ToDoManager
//
//  Created by David Reyes Pucheta on 12/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "MyUITableViewCell.h"

@implementation MyUITableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setInternalFields:(ToDoEntity *) incomingToDoEntity {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];

    self.toDoTitleLabel.text = incomingToDoEntity.toDoTitle;
    self.localToDoEntity = incomingToDoEntity;
    
    NSString *strDate = [dateFormatter stringFromDate:incomingToDoEntity.toDoDueDate];
    self.toDoDueDateLabel.text = strDate;

    
    
}



@end
