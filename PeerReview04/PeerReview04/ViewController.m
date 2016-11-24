//
//  ViewController.m
//  PeerReview04
//
//  Created by David Reyes Pucheta on 22/10/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *startLocation;

@property (weak, nonatomic) IBOutlet UITextField *endLocationA;
@property (weak, nonatomic) IBOutlet UILabel *distanceA;

@property (weak, nonatomic) IBOutlet UITextField *endLocationB;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;

@property (weak, nonatomic) IBOutlet UITextField *endLocationC;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *unitsController;

@end

@implementation ViewController

- (IBAction)calculateButtonTapped:(id)sender {

    self.calculateButton.enabled = NO;
    
    self.req = [DGDistanceRequest alloc];
    NSString *start = self.startLocation.text;
    
    NSString *destA = self.endLocationA.text;
    NSString *destB = self.endLocationB.text;
    NSString *destC = self.endLocationC.text;
    
    NSArray *dests = @[destA,destB,destC];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^void(NSArray *responses){
        
        ViewController *strongSelf = weakSelf;
    
        if (!strongSelf) return;
        
        NSNull *badResult = [NSNull null];
        int index = strongSelf.unitsController.selectedSegmentIndex;
        
        //Distance A
        if (responses[0] != badResult) {
            double numA;
            if (index == 0) {
                numA = ([responses[0] floatValue]);
                NSString *a = [NSString stringWithFormat:@"%.2f m.", numA];
                strongSelf.distanceA.text = a;
            }
            else if (index == 1) {
                numA = ([responses[0] floatValue]/1000.0);
                NSString *a = [NSString stringWithFormat:@"%.2f Km.", numA];
                strongSelf.distanceA.text = a;
            }
            else{
                numA = ([responses[0] floatValue]/1609.344 );
                NSString *a = [NSString stringWithFormat:@"%.2f miles", numA];
                strongSelf.distanceA.text = a;
            }
        }
        else{
            strongSelf.distanceA.text = @"Error";
        }
        
        //Distance B
        if (responses[1] != badResult) {
            double numB;
            if (index == 0) {
                numB = ([responses[1] floatValue]);
                NSString *b = [NSString stringWithFormat:@"%.2f m.", numB];
                strongSelf.distanceB.text = b;
            }
            else if (index == 1) {
                numB = ([responses[1] floatValue]/1000.0);
                NSString *b = [NSString stringWithFormat:@"%.2f Km.", numB];
                strongSelf.distanceB.text = b;
            }
            else{
                numB = ([responses[1] floatValue]/1609.344 );
                NSString *b = [NSString stringWithFormat:@"%.2f miles", numB];
                strongSelf.distanceB.text = b;
            }
        }
        else{
            strongSelf.distanceB.text = @"Error";
        }
        
        //Distance C
        if (responses[2] != badResult) {
            double numC;
            if (index == 0) {
                numC = ([responses[2] floatValue]);
                NSString *c = [NSString stringWithFormat:@"%.2f m.", numC];
                strongSelf.distanceC.text = c;
            }
            else if (index == 1) {
                numC = ([responses[2] floatValue]/1000.0);
                NSString *c = [NSString stringWithFormat:@"%.2f Km.", numC];
                strongSelf.distanceC.text = c;
            }
            else{
                numC = ([responses[2] floatValue]/1609.344 );
                NSString *c = [NSString stringWithFormat:@"%.2f miles", numC];
                strongSelf.distanceC.text = c;
            }
        }
        else{
            strongSelf.distanceC.text = @"Error";
        }
        
        strongSelf.req = nil;
        strongSelf.calculateButton.enabled = YES;
    };
    
    [self.req start];
 
}

@end
