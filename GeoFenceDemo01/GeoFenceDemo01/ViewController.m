//
//  ViewController.m
//  GeoFenceDemo01
//
//  Created by David Reyes Pucheta on 31/03/16.
//  Copyright © 2016 David Reyes Pucheta. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *uiSwitch;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *statusCheck;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, assign) BOOL mapIsMoving;

@property (strong, nonatomic) MKPointAnnotation *curretAnno;

@property (strong, nonatomic) CLCircularRegion *geoRegion;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //turn off user  UI until permission
    self.uiSwitch.enabled = NO;
    self.statusCheck.enabled = NO;
    
    self.mapIsMoving = NO;
    
    self.eventLabel.text = @"";
    self.statusLabel.text = @"";
    
    //Setup location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 2; //meters
    
    //Zoom the map very close
    CLLocationCoordinate2D noLocation;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(noLocation, 500, 500);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion];
    
    //Create an annotation for the user's location
    [self addCurrentAnnotation];
    
    //Setup the goregion object
    [self setUpGeoRegion];
    
    //check if the device can do geofences
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]] == YES) {
        //regardless of auth, if hw can support it set up a georegion
        //[self setUpGeoRegion];
        
        CLAuthorizationStatus currentStatus = [CLLocationManager authorizationStatus];
        if ( currentStatus == kCLAuthorizationStatusAuthorizedWhenInUse || currentStatus == kCLAuthorizationStatusAuthorizedAlways) {
            self.uiSwitch.enabled = YES;
        }        else {
            //if not authorized try and get authorization
            [self.locationManager requestAlwaysAuthorization];
            
        }
        
        //Ask for notifications permissions if the app is in the background
        UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        
    }
    else {
        self.statusLabel.text = @"GeoRegions not supported";
    }
}

- (void) locationManager:(CLLocationManager *) manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    CLAuthorizationStatus currentStatus = [CLLocationManager authorizationStatus];
    if ( currentStatus == kCLAuthorizationStatusAuthorizedWhenInUse || currentStatus == kCLAuthorizationStatusAuthorizedAlways) {
        self.uiSwitch.enabled = YES;
    }
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    self.mapIsMoving = YES;
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.mapIsMoving = NO;
}

- (void) setUpGeoRegion {
    //Create the geographic region to b monitored
    self.geoRegion = [[CLCircularRegion alloc]
                      initWithCenter:CLLocationCoordinate2DMake(19.529414,-96.893846)
                      radius:2
                      identifier:@"MyRegionIdentifier"];
}

- (IBAction)switchTapped:(id)sender {
    if (self.uiSwitch.isOn){
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
        [self.locationManager startMonitoringForRegion:self.geoRegion];
        self.statusCheck.enabled = YES;
    }
    else {
        self.statusCheck.enabled = NO;
        [self.locationManager stopMonitoringForRegion:self.geoRegion];
        [self.locationManager stopUpdatingLocation];
        self.mapView.showsUserLocation = NO;
    }
}

- (void) addCurrentAnnotation {
    self.curretAnno = [[MKPointAnnotation alloc] init];
    self.curretAnno.coordinate = CLLocationCoordinate2DMake(0.0,0.0);
    self.curretAnno.title = @"My Location";
}

- (void) centerMap:(MKPointAnnotation *)centerPoint {
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
}

#pragma mark - location call backs

- (void) locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    
    if (state == CLRegionStateUnknown) {
        self.statusLabel.text = @"Unknown";
    } else if (state == CLRegionStateInside) {
        self.statusLabel.text = @"Inside";
    } else if (state == CLRegionStateOutside) {
        self.statusLabel.text = @"Outside";
    } else {
        self.statusLabel.text = @"Mistery";
    }
    
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    self.curretAnno.coordinate = locations.lastObject.coordinate;
    
    if (self.mapIsMoving == NO){
        [self centerMap:self.curretAnno];
    }
    
}

- (void) locationManager:(CLLocationManager *)manager didEnterRegion:(nonnull CLRegion *)region {
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.fireDate = nil;
    note.repeatInterval = 0;
    note.alertTitle = @"GepFence Alert!";
    note.alertBody = [NSString stringWithFormat:@"You entered the geofence"];
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    
    self.eventLabel.text = @"Entered";
}

- (void) locationManager:(CLLocationManager *)manager didExitRegion:(nonnull CLRegion *)region {
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.fireDate = nil;
    note.repeatInterval = 0;
    note.alertTitle = @"GepFence Alert!";
    note.alertBody = [NSString stringWithFormat:@"You left the geofence"];
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
    
    self.eventLabel.text = @"Exited";
}

- (IBAction)statusCheckTapped:(id)sender {
    [self.locationManager requestStateForRegion:self.geoRegion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
