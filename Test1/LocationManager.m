//
//  LocationManager.m
//  Test1
//
//  Created by Roee Nadam on 12/25/15.
//  Copyright © 2015 Nadam. All rights reserved.
//


#import "LocationManager.h"


static CGPoint * geoPoint;



@implementation LocationManager
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@synthesize locationManager;

+(void)set_GeoPointValue:(CLLocation *)GeoPoint
{
    geoPoint = (__bridge CGPoint *)(GeoPoint);
}

+(CLLocation*)get_GeoPointValue
{
    return (__bridge CLLocation *)(geoPoint);
}

-(id)initLocationManagerWithParent:(id)parent
{
    self = [super init];
    if (self)
    {
        [self setLoacation];
    }
    return self;
}


#pragma mark -gps location

-(void)setLoacation
{
    geocoder = [[CLGeocoder alloc] init];
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.delegate = self;
    }
    
    [locationManager startUpdatingLocation];
    [locationManager requestAlwaysAuthorization];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    
    [LocationManager set_GeoPointValue:newLocation];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil&& [placemarks count] >0)
         {
             placemark = [placemarks lastObject];
             //            NSString *latitude, *longitude, *state, *country;
             //            latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
             //            longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
             //            state = placemark.administrativeArea;
//             [AppDelegate set_ISOcountryCode:placemark.ISOcountryCode];
         }
         else
         {
             NSLog(@"%@", error.debugDescription);
         }
     }];
//     Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}

-(void)checkIfUserEnabledLocationServices
{
    if([CLLocationManager locationServicesEnabled])
    {
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Location Services Permission Denied -> Please go to Settings and turn on Location Service for MOTO."
                                                             message:@""
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
            [alert show];
        }
    }
}



@end
