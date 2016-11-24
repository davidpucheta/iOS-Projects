//
//  ViewController.m
//  FourPanelDemo
//
//  Created by David Reyes Pucheta on 20/01/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "MapKit/Mapkit.h"
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *webURL = @"https://www.facebook.com/xalapanuestracapital";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:webURL]];
    [self.webView loadRequest:request];
    
    //Center the map
    double latitude = 19.526363;
    double longitude = -96.897714;
    
    MKPointAnnotation *homeAnno = [[MKPointAnnotation alloc] init];
    homeAnno.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    homeAnno.title =@"My hometown";
    
    [self.mapView addAnnotation:homeAnno];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(homeAnno.coordinate, 10000, 10000);
    MKCoordinateRegion adjusted = [self.mapView regionThatFits:region];
    [self.mapView setRegion:adjusted animated:YES];
    
    
}


@end
