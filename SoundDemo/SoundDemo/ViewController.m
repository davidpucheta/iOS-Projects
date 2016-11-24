//
//  ViewController.m
//  SoundDemo
//
//  Created by David Reyes Pucheta on 15/04/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
@import AudioToolbox;
@import AVFoundation.AVAudioPlayer;

@interface ViewController ()

@property (assign, nonatomic) SystemSoundID beepA;
@property (assign, nonatomic) SystemSoundID beepB;
@property (assign,nonatomic) BOOL beepAGood;
@property (assign,nonatomic) BOOL beepBGood;

@property (strong, nonatomic) AVAudioPlayer *player;
@property (assign,nonatomic) BOOL songGood;

@end

@implementation ViewController

- (void) dealloc {
    if (self.beepAGood){
        AudioServicesDisposeSystemSoundID(self.beepA);
    }
    
    if (self.beepBGood){
        AudioServicesDisposeSystemSoundID(self.beepB);
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Load the sounds // create the sound ID
    NSString *soundAPath = [[NSBundle mainBundle] pathForResource:@"clipA" ofType:@"aif"];
    NSURL *urlA = [NSURL fileURLWithPath:soundAPath];
    
    NSString *soundBPath = [[NSBundle mainBundle] pathForResource:@"clipB" ofType:@"aif"];
    NSURL *urlB = [NSURL fileURLWithPath:soundBPath];
    
    NSString *songPath = [[NSBundle mainBundle] pathForResource:@"media" ofType:@"mp3"];
    NSURL *urlC = [NSURL fileURLWithPath:songPath];
    
    
    //Archaic C code
    //
    //
    //
    
    OSStatus statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) urlA,  &_beepA);
    if (statusReport == kAudioServicesNoError){
        self.beepAGood = YES;
    }else {
        self.beepAGood = NO;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load beepA" message:@"BeepA problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    statusReport = AudioServicesCreateSystemSoundID((__bridge CFURLRef) urlB,  &_beepB);
    if (statusReport == kAudioServicesNoError){
        self.beepBGood = YES;
    }else {
        self.beepBGood = NO;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load beepB" message:@"BeepB problem" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    //setup AVAudioPlayer
    NSError *err;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlC error:&err];
    
    if (!self.player) {
        self.songGood = NO;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Couldn't load mp3" message:[err localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        self.songGood = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playSoundA:(id)sender {
    
    if (self.beepAGood){
        AudioServicesPlaySystemSound(self.beepA);
    }
    
}


- (IBAction)playSoundB:(id)sender {
    
    if (self.beepBGood){
        AudioServicesPlaySystemSound(self.beepB);
    }

}


- (IBAction)playMedia:(id)sender {
    if (self.songGood){
        [self.player play];
    }
}


- (IBAction)stopMedia:(id)sender {
    if (self.songGood){
        [self.player stop];
    }
}

@end
