//
//  ViewController.m
//  CoreDataApp
//
//  Created by David Reyes Pucheta on 26/11/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UITextField *choreField;
@property (weak, nonatomic) IBOutlet UILabel *persistedData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self updateLogList];

}

- (IBAction)deleteTapped:(id)sender {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if (!results){
        NSLog(@"Error fetching Person Objects %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (ChoreMO *c in results) {
        [moc deleteObject:c];
    }
    
    [self.appDelegate saveContext];
    
    [self updateLogList];
    
}

- (IBAction)choreTapped:(id)sender {
    ChoreMO *c = [self.appDelegate CreateChoreMO];
    c.chore_name = self.choreField.text;
    [self.appDelegate saveContext];
    [self updateLogList];
}

-(void) updateLogList{
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if (!results){
        NSLog(@"Error fetching Person Objects %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSMutableString *buffer = [NSMutableString stringWithString:@""];
    
    for (ChoreMO *c in results) {
        [buffer appendFormat:@"\n%@", c.chore_name, nil];
    }
    
    self.persistedData.text = buffer;
    
}

@end
