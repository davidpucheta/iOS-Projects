//
//  ViewController.m
//  PeerReview03
//
//  Created by David Reyes Pucheta on 16/10/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
#import "CurrencyRequest/CRCurrencyRequest.h"
#import "CurrencyRequest/CRCurrencyResults.h"

@interface ViewController () <CRCurrencyRequestDelegate>

@property (nonatomic) CRCurrencyRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UILabel *currencyA;
@property (weak, nonatomic) IBOutlet UILabel *currencyB;
@property (weak, nonatomic) IBOutlet UILabel *currencyC;

@end

@implementation ViewController

- (IBAction)buttonTapped:(id)sender {
    self.convertButton.enabled = NO;
    
    self.req = [[CRCurrencyRequest alloc] init];
    self.req.delegate = self;
    [self.req start];
}

- (void)currencyRequest:(CRCurrencyRequest *)req
    retrievedCurrencies:(CRCurrencyResults *)currencies{
    
    double inputVal = [self.inputField.text floatValue];
    
    double pesoVal = inputVal * currencies.MXN;
    NSString * peso = [NSString stringWithFormat:@"%.2f", pesoVal];
    
    double euroVal = inputVal * currencies.EUR;
    NSString * euro = [NSString stringWithFormat:@"%.2f", euroVal];
    
    double inrVal = inputVal * currencies.INR;
    NSString * inr = [NSString stringWithFormat:@"%.2f", inrVal];
    
    self.currencyA.text = peso;
    self.currencyB.text = euro;
    self.currencyC.text = inr;
    
    self.convertButton.enabled = YES;
}



@end
