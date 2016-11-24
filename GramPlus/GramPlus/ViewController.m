//
//  ViewController.m
//  GramPlus
//
//  Created by David Reyes Pucheta on 10/11/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
#import "NXOAuth2.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoutButton.enabled = false;
    self.refreshButton.enabled = false;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonPressed:(id)sender {
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"Instagram"];
    self.logoutButton.enabled = true;
    self.loginButton.enabled = false;
    self.refreshButton.enabled = true;
}

- (IBAction)logoutButtonPressed:(id)sender {
    NXOAuth2AccountStore *store = [NXOAuth2AccountStore sharedStore];
    NSArray *instagramAccounts = [store accountsWithAccountType:@"Instagram"];
    for (id acct in instagramAccounts) {
        [store removeAccount:acct];
    }
    self.logoutButton.enabled = false;
    self.loginButton.enabled = true;
    self.refreshButton.enabled = false;
}

- (IBAction)refreshButtonPressed:(id)sender {
    NSArray *instagramAccounts = [[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"Instagram"];
    if ([instagramAccounts count] == 0) {
        NSLog(@"Warning %ld Instagrams accounts logged in", (long)[instagramAccounts count]);
        return;
    }
    
    NXOAuth2Account *acct = instagramAccounts[0];
    NSString *token = acct.accessToken.accessToken;
    
    NSString *urlStr = [@"https://api.instagram.com/v1/users/self/feed?access_token=" stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData *_Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        //Check for network error
        if (error) {
            NSLog(@"Error: Couldn't finish request: %@", error);
            return;
        }
        
        //Check for http error
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
        if (httpResp.statusCode < 200 || httpResp.statusCode >= 300) {
            NSLog(@"Error: Got status code %ld", (long)httpResp.statusCode);
            return;
        }
        
        //Check for JSON parse error
        NSError *parserError;
        id pkg = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parserError];
        if (!pkg) {
            NSLog(@"Error: Couldn't parse response: %@", parserError);
            return;
        }
        
        //Pull URL in question
        NSString *imageURLStr = pkg[@"data"][0][@"images"][@"standard_resolution"][@"url"];
        NSURL *imageURL = [NSURL URLWithString:imageURLStr];
        [[session dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //Check for network error
            if (error) {
                NSLog(@"Error: Couldn't finish request: %@", error);
                return;
            }
            
            //Check for http error
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
            if (httpResp.statusCode < 200 || httpResp.statusCode >= 300) {
                NSLog(@"Error: Got status code %ld", (long)httpResp.statusCode);
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithData:data];
            });
            

        }]resume];
        
    }] resume];
    
}

@end
