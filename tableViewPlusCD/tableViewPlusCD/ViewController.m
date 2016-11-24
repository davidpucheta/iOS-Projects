//
//  ViewController.m
//  tableViewPlusCD
//
//  Created by David Reyes Pucheta on 11/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
#import "ToDoEntity.h"
#import "TableViewCell.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) NSFetchedResultsController *resultsController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:self.myContext];

    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES]];
    
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.myContext sectionNameKeyPath:nil cacheName:nil];
    
    self.resultsController.delegate = self;
    
    NSError *err;
    BOOL fetchSucceeded = [self.resultsController performFetch:&err];
    
    if (!fetchSucceeded) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't fetch" userInfo:nil];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)todoTapped:(id)sender {
    
    //Get the text
    NSString *text = self.textField.text;
    NSManagedObjectContext *ctx = self.myContext;
    
    //Store the text in a CoreData Object
    ToDoEntity *item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity" inManagedObjectContext:ctx];
    item.title = text;
    
    //Save the CoreData object
    NSError *error;
    BOOL saveSuccess = [ctx save:&error];
    if (!saveSuccess) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Couldn't save" userInfo:@{NSUnderlyingErrorKey:error}];
    } else {
        self.textField.text = nil;
    }

}


#pragma mark - TableViewDelegates

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsController.sections[section].numberOfObjects;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToDoEntity *item = self.resultsController.sections[indexPath.section].objects[indexPath.row];
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    [cell setTitle:item];
    
    return cell;
}

#pragma mark - NSFetchedResultDelegate implementations

- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView beginUpdates];
    
}


- (void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate: {
            TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            ToDoEntity *item = [controller objectAtIndexPath:indexPath];
            [cell setTitle:item];
            break;
        }
        case NSFetchedResultsChangeMove:{
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
    
}


- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView endUpdates];
    
}

@end























