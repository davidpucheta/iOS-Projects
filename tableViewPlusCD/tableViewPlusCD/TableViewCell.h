//
//  TableViewCell.h
//  tableViewPlusCD
//
//  Created by David Reyes Pucheta on 11/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity.h"

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

- (void) setTitle:(ToDoEntity *)incoming;


@end
