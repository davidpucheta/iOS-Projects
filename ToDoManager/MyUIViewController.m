//
//  MyUIViewController.m
//  ToDoManager
//
//  Created by David Reyes Pucheta on 12/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "MyUIViewController.h"

@interface MyUIViewController ()

@property (strong,nonatomic) NSManagedObjectContext * managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *detailsField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDateField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITextField *tagField;



@property (nonatomic, assign) BOOL wasDeleted;

@property (strong,nonatomic) ToDoEntity *localToDoEntity;
@end

@implementation MyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textViewDidEndEditing:(NSNotification *) notification {
    
    if ([notification object] == self){
        self.localToDoEntity.toDoDetails = self.detailsField.text;
        [self saveMyToDoEntity];
    }

}


- (IBAction)trashTapped:(id)sender {
    self.wasDeleted = YES;
    
    [self.managedObjectContext deleteObject:self.localToDoEntity];
    [self saveMyToDoEntity];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



- (void) saveMyToDoEntity {
    NSError *err;
    BOOL saveSuccess = [self.managedObjectContext save:&err];
    if (!saveSuccess) {
        @throw [NSException exceptionWithName:NSGenericException    reason:@"Couldn't Save"  userInfo:@{NSUnderlyingErrorKey:err}];
    }
    
    
}

- (void) viewWillAppear:(BOOL)animated {

    self.wasDeleted = NO;
    
    self.titleField.text = self.localToDoEntity.toDoTitle;
    self.locationField.text = self.localToDoEntity.toDoLocation;
    self.tagField.text = self.localToDoEntity.toDoTag;
    self.detailsField.text = self.localToDoEntity.toDoDetails;

    NSDate *dueDate = self.localToDoEntity.toDoDueDate;
    if (dueDate != nil) {
        [self.dueDateField setDate:dueDate];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    
}

- (void) viewWillDisappear:(BOOL)animated{
    
    if (self.wasDeleted == NO){
        self.localToDoEntity.toDoTitle = self.titleField.text;
        self.localToDoEntity.toDoDetails = self.detailsField.text;
        self.localToDoEntity.toDoDueDate = self.dueDateField.date;
        self.localToDoEntity.toDoLocation = self.locationField.text;
        self.localToDoEntity.toDoTag = self.tagField.text;
        [self saveMyToDoEntity];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
    
}


- (IBAction)titleFieldEdited:(id)sender {
    self.localToDoEntity.toDoTitle = self.titleField.text;
    
    [self saveMyToDoEntity];
    
}

- (IBAction)dueDateEdited:(id)sender {
    
    self.localToDoEntity.toDoDueDate = self.dueDateField.date;
    
    [self saveMyToDoEntity];
}

- (IBAction)locationFieldEdited:(id)sender {
    self.localToDoEntity.toDoLocation = self.locationField.text;
    [self saveMyToDoEntity];
}


- (IBAction)tagFieldEdited:(id)sender {
        self.localToDoEntity.toDoTag = self.tagField.text;
    [self saveMyToDoEntity];
}


- (void) receiveMOC:(NSManagedObjectContext *)incomingMOC {
    
    self.managedObjectContext = incomingMOC;
    
}


- (void) receiveToDoEntity:(ToDoEntity *) incomingToDoEntity {
    self.localToDoEntity = incomingToDoEntity;
}




@end
