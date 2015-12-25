//
//  LocationManager.h
//  Test1
//
//  Created by Roee Nadam on 12/25/15.
//  Copyright © 2015 Nadam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

-(id)initLocationManager;


+(void)set_GeoPointValue:(CLLocation *)GeoPoint;
+(CLLocation*)get_GeoPointValue;

@end
