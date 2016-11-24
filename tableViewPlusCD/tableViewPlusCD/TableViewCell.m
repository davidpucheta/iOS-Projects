//
//  TableViewCell.m
//  tableViewPlusCD
//
//  Created by David Reyes Pucheta on 11/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "TableViewCell.h"
#import "ToDoEntity.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTitle:(ToDoEntity *)incoming {
    
    self.cellLabel.text = incoming.title;

}

@end
