//
//  ViewController.m
//  twiiterShare
//
//  Created by David Reyes Pucheta on 02/11/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UITextView *fbTextView;
@property (weak, nonatomic) IBOutlet UITextView *otherTextView;

- (void) configureTweetTextView;
- (void) showAlertMessage:(NSString *) myMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTweetTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showAlertMessage:(NSString *) myMessage{
    UIAlertController *alertController;
    alertController = [UIAlertController alertControllerWithTitle:@"SocialShare" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)showShareAction:(id)sender {
    
    if([self.tweetTextView isFirstResponder]){
        [self.tweetTextView resignFirstResponder];
    }
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        //tweet the tweet
        if ([self.tweetTextView.text length] < 140) {
            [twitterVC setInitialText:self.tweetTextView.text];
        }
        else{
            NSString *shortText = [self.tweetTextView.text substringToIndex:140];
            [twitterVC setInitialText:shortText];
        }
        [self presentViewController:twitterVC animated:YES completion:nil];
    }
    else{
        //Throw objection
        [self showAlertMessage:@"You are not signed in to Twitter"];
    }
}

- (IBAction)fbShareAction:(id)sender {
    
    if([self.fbTextView isFirstResponder]){
        [self.fbTextView resignFirstResponder];
    }
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookVC setInitialText:self.fbTextView.text];
        [self presentViewController:facebookVC animated:YES completion:nil];
    }
    else{
        [self showAlertMessage:@"You are not signed in to FB"];
    }
}

- (IBAction)otherShareAction:(id)sender {
    
    if([self.otherTextView isFirstResponder]){
        [self.otherTextView resignFirstResponder];
    }
    
    UIActivityViewController *moreVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.otherTextView.text] applicationActivities:nil];
    [self presentViewController:moreVC animated:YES completion:nil];
}

- (IBAction)noneShareAction:(id)sender {
    UIAlertController *noneActionController = [UIAlertController alertControllerWithTitle:@"SocialShare" message:@"This does nothing" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
    [noneActionController addAction:okAction];
    [self presentViewController:noneActionController animated:YES completion:nil];
}

- (void) configureTweetTextView{
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:0.1 green:0.8 blue:1.0 alpha:1.0].CGColor;
    self.tweetTextView.layer.cornerRadius = 10;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;
    
    self.fbTextView.layer.backgroundColor = [UIColor colorWithRed:0.4 green:0.5 blue:0.7 alpha:1.0].CGColor;
    self.fbTextView.layer.cornerRadius = 10;
    self.fbTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.fbTextView.layer.borderWidth = 2.0;
    
    self.otherTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.otherTextView.layer.cornerRadius = 10;
    self.otherTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.otherTextView.layer.borderWidth = 2.0;
    
}

@end
