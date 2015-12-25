//
//  AppDelegate.m
//  Test1
//
//  Created by Roee Nadam on 12/21/15.
//  Copyright © 2015 Nadam. All rights reserved.
//

#import "AppDelegate.h"
//#import "LocationManager.h"

@interface AppDelegate ()
@end

static NSString * longitude;
static NSString * latitude;
static BOOL finishSetGeoPoint;


@implementation AppDelegate
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;

}
@synthesize locationManager;


+(void)set_latitudeValue:(NSString *)GeoPoint
{
    latitude = GeoPoint;
}

+(NSString*)get_latitudeValue
{
    return latitude;
}

+(void)set_longitudeValue:(NSString *)GeoPoint
{
    longitude = GeoPoint;
}

+(NSString*)get_longitudeValue
{
    return longitude;
}

+(void)set_finishSetGeoPoint:(BOOL)flag
{
    finishSetGeoPoint = flag;
}

+(BOOL)get_finishSetGeoPoint
{
    return finishSetGeoPoint;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    LocationManager * locationManager = [[LocationManager alloc]initLocationManager];
//    [locationManager initLocationManager];
    
    [self setLoacation];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



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

    
    
//    NSString *linkForWoeid = [NSString stringWithFormat:@" http://where.yahooapis.com/geocode?location=%f,%f&flags=J&gflags=R&appid=zHgnBS4m",newLocation.coordinate.latitude,newLocation.coordinate.longitude];
//    NSURL *woeidURL = [NSURL URLWithString:linkForWoeid];
//    NSData *WoeidData = [NSData dataWithContentsOfURL:woeidURL];
//    if (WoeidData != NULL)
//    {
//        NSError *woeiderr = nil;
//        NSDictionary *aDicWOEIDResp = [NSJSONSerialization JSONObjectWithData:WoeidData options:NSJSONReadingMutableContainers error:&woeiderr];
//        NSDictionary *aDictWOEID = [[[[aDicWOEIDResp objectForKey:@"ResultSet"]objectForKey:@"Results"]objectAtIndex:0]objectForKey:@"woeid"];
//        
//        NSString *address=[NSString stringWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%@",aDictWOEID];
//    
//    
//    }
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil&& [placemarks count] >0)
         {
             placemark = [placemarks lastObject];
                         NSString *latitude, *longitude, *state, *country;
                         latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
                         longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
                         state = placemark.administrativeArea;
//                          [AppDelegate set_ISOcountryCode:placemark.ISOcountryCode];
             
             [AppDelegate set_latitudeValue:latitude];
             [AppDelegate set_longitudeValue:longitude];
             [AppDelegate set_finishSetGeoPoint:YES];
             
//             for(CLPlacemark *placemark in placemarks)
//             {
//                 NSLog(@"plcaemark desc : %@",[placemark description]);
//             }
             
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
