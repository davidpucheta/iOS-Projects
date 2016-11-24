//
//  ViewController.m
//  KeyboardDemo
//
//  Created by David Reyes Pucheta on 04/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *ctr = [NSNotificationCenter defaultCenter];
    [ctr addObserver:self selector:@selector (moveKeyboardInResponseToWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    [ctr addObserver:self selector:@selector(moveKeyboardInResponseToWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)resignButton:(id)sender {
    [self.textField resignFirstResponder];
}

- (void) moveKeyboardInResponseToWillShowNotification:(NSNotification *) notification {

    NSDictionary *info = [notification userInfo];
    
    CGRect kbRect;
    kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    UIViewAnimationCurve curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self.view layoutSubviews];
    
    //Iniciar Animación
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.bottomLayout.constant = kbRect.size.height;
    [self.view layoutSubviews];
    
    [UIView commitAnimations];
}

- (void) moveKeyboardInResponseToWillHideNotification:(NSNotification *)notification{
    
    NSDictionary *info = [notification userInfo];
    
    CGRect kbRect;
    kbRect = CGRectZero;
    
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    UIViewAnimationCurve curve = [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self.view layoutSubviews];
    
    //Iniciar Animación
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.bottomLayout.constant = kbRect.size.height;
    [self.view layoutSubviews];
    
    [UIView commitAnimations];
}

@end
