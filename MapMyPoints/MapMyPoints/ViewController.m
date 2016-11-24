//
//  ViewController.m
//  MapMyPoints
//
//  Created by David Reyes Pucheta on 04/02/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "MapKit/MapKit.h"
#import "ViewController.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@property (strong, nonatomic) MKPointAnnotation * maxAnno;
@property (strong, nonatomic) MKPointAnnotation * mixAnno;
@property (strong, nonatomic) MKPointAnnotation * pinacotecaAnno;
@property (strong, nonatomic) MKPointAnnotation * currentAnno;


@property (weak, nonatomic) IBOutlet UISwitch *switchLocateMe;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, assign) BOOL mapIsMoving;
@end

@implementation ViewController

- (IBAction)switchChanged:(id)sender {
    
    if (self.switchLocateMe.isOn) {
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    }else{
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    self.currentAnno.coordinate =locations.lastObject.coordinate;
    if (self.mapIsMoving == NO) {
        [self centerMap:self.currentAnno];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.mapIsMoving = NO;
    
    [self addAnnotations];
}

- (IBAction)btn1tapped:(id)sender {
    [self centerMap:self.maxAnno];
}

- (IBAction)btn2Tapped:(id)sender {
    [self centerMap:self.mixAnno];
}

- (IBAction)btn3Tapped:(id)sender {
    [self centerMap:self.pinacotecaAnno];
}

- (void) centerMap:(MKPointAnnotation *) centerPoint{
    
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
    
}

-(void) addAnnotations{
    
    self.maxAnno = [[MKPointAnnotation alloc] init];
    self.maxAnno.coordinate = CLLocationCoordinate2DMake(19.550557, -96.930998);
    self.maxAnno.title = @"Museo de Antropología de Xalapa";
    
    self.mixAnno = [[MKPointAnnotation alloc] init];
    self.mixAnno.coordinate = CLLocationCoordinate2DMake(19.518358, -96.894032);
    self.mixAnno.title = @"Museo Interactivo de Xalapa";
    
    self.pinacotecaAnno = [[MKPointAnnotation alloc] init];
    self.pinacotecaAnno.coordinate = CLLocationCoordinate2DMake(19.526436, -96.924282);
    self.pinacotecaAnno.title = @"Pinacoteca Diego Rivera";
    
    self.currentAnno = [[MKPointAnnotation alloc] init];
    self.currentAnno.coordinate = CLLocationCoordinate2DMake(0, 0);
    self.currentAnno.title = @"My Location";
    
    [self.mapView addAnnotations:@[self.maxAnno,self.mixAnno, self.pinacotecaAnno]];
    
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    self.mapIsMoving = YES;
}


- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    self.mapIsMoving = NO;
}

@end
