//
//  ViewController.m
//  PeerReview
//
//  Created by David Reyes Pucheta on 29/09/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testButtonTapped:(id)sender {
    self.testLabel.text = @"It Worked!";
}

@end
