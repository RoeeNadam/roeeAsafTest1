//
//  AppDelegate.h
//  Test1
//
//  Created by Roee Nadam on 12/21/15.
//  Copyright © 2015 Nadam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<CoreLocation/CoreLocation.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>


@property (nonatomic, retain) CLLocationManager *locationManager;

@property (strong, nonatomic) UIWindow *window;


+(void)set_latitudeValue:(NSString *)GeoPoint;
+(NSString*)get_latitudeValue;

+(void)set_longitudeValue:(NSString *)GeoPoint;
+(NSString*)get_longitudeValue;

+(void)set_finishSetGeoPoint:(BOOL)flag;
+(BOOL)get_finishSetGeoPoint;



@end

