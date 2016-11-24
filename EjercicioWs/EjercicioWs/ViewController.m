//
//  ViewController.m
//  EjercicioWs
//
//  Created by David Reyes Pucheta on 23/10/15.
//  Copyright © 2015 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
#import "MWKwsDemostracionBinding.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextView *respuestaField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


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
- (IBAction)loginBtnTapped:(id)sender {
    MWKwsDemostracionBinding *service = [[MWKwsDemostracionBinding alloc]init];
    NSString *usr = self.userField.text;
    NSString *pass = self.passwordField.text;
    //NSError *er = nil;
    //[service LoginUsuario:usr Password:pass __error:&er];
    
    [service LoginUsuarioAsync:usr Password:pass __target:self __handler:@selector(handler:)];
    
    
    
}

- (void) handler:(id) obj {
    self.respuestaField.text = obj;
}

@end
