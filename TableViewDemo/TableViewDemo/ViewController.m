//
//  ViewController.m
//  TableViewDemo
//
//  Created by David Reyes Pucheta on 08/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
#import "MyCellTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *ourStrings;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.ourStrings = [NSMutableArray arrayWithArray:@[@"The first Row!", @"More Data"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTapped:(id)sender {
    
    [self.tableView beginUpdates];
    
    [self.ourStrings addObject:self.textField.text];
    NSInteger newRow = [self.ourStrings count] -1;
    NSIndexPath *newIndex = [NSIndexPath indexPathForRow:newRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[newIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
    
    self.textField.text = @"";
    
}

- (IBAction)sortTapped:(id)sender {
    for (long i= [self.ourStrings count]-2;i >=0; i--){
        for (long j = i; j<[self.ourStrings count]-1;j++){
            if ([self.ourStrings[j] compare:self.ourStrings[j+1]] > 0 ) {
                
                 [self.tableView beginUpdates];
   
                [self.ourStrings exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                
                NSIndexPath *firstIndex = [NSIndexPath indexPathForRow:j inSection:0];
                NSIndexPath *secondtIndex = [NSIndexPath indexPathForRow:j+1 inSection:0];
                [self.tableView moveRowAtIndexPath:firstIndex toIndexPath:secondtIndex];
                
              [self.tableView endUpdates];
            }
        }
    }
    
}



#pragma mark UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ourStrings.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     MyCellTableViewCell * cell = (MyCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"OurCell" forIndexPath:indexPath];
    
    cell.ourCellLabel.text = self.ourStrings[indexPath.row];
    return cell;
}


@end
