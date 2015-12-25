//
//  ViewController.m
//  Test1
//
//  Created by Roee Nadam on 12/21/15.
//  Copyright © 2015 Nadam. All rights reserved.
//

#import "ViewController.h"
#import "YQL.h"
#import "LocationManager.h"
#import "AppDelegate.h"

NSString * waveHeightValue;
NSString * statusValue;
float degreesValue;
NSString * humidityValue;
float windValue;

NSString * addressValue;

NSString * longitude;
NSString * latitude;



@implementation ViewController


@synthesize waveHeight,status,degreesLable,windImageView,windLable,addressLable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setGeneralProperties];
    [self setLables];
    [self checkIfHaveGeoPoint];


}

-(void)viewDidAppear:(BOOL)animated
{
}

-(void)checkIfHaveGeoPoint
{
    if ([AppDelegate get_finishSetGeoPoint])
    {
        [self loadDataFromYahoo];
    }
    else
    {
        
        [self performSelector:@selector(checkIfHaveGeoPoint) withObject:nil afterDelay:0.1];
    }
}




-(void)setGeneralProperties
{

    
    self.view.backgroundColor = [UIColor blackColor];
 
    waveHeightValue = @"0";
    statusValue = @"0";
    degreesValue = 0;
    humidityValue = @"0";
    windValue = 0;

}


-(void)loadDataFromYahoo
{
    // Download the following GitHub repository https://github.com/guilhermechapiewski/yql-ios
    // Copy the yql-ios folder to your project
    YQL *yql = [[YQL alloc] init];
    
    NSString * latitude = [AppDelegate get_latitudeValue];
    NSString * longitude = [AppDelegate get_longitudeValue];
    
    NSString *text = [NSString stringWithFormat:@"%@,%@",latitude,longitude];
    NSString *r = @"R";
//    select * from geo.placefinder where text="25.946314,83.534546" and gflags="R"

    NSString * queryString  = [NSString stringWithFormat:@"select * from geo.placefinder where text=\"%@\" and gflags=\"%@\"" ,text , r];
    
    NSDictionary *results = [yql query:queryString];
   
    
    NSString * wobid = [[[[results valueForKey:@"query"] valueForKey:@"results"] valueForKey:@"Result"] valueForKey:@"woeid"];

    addressValue = [[[[results valueForKey:@"query"] valueForKey:@"results"] valueForKey:@"Result"] valueForKey:@"singleLineAddress"];
    
    NSString *queryString2 = [NSString stringWithFormat:@"select * from weather.forecast where woeid=%@",wobid];
    NSDictionary *results2 = [yql query:queryString2];

    
    NSString * temp = [[[[[[results2 objectForKey:@"query"] valueForKey:@"results"] valueForKey:@"channel"]valueForKey:@"item"] valueForKey:@"condition"] valueForKey:@"temp"];
    NSString * humidity = [[[[[results2 objectForKey:@"query"] valueForKey:@"results"] valueForKey:@"channel"]valueForKey:@"atmosphere"] valueForKey:@"humidity"];
    float wind = [[[[[[results2 objectForKey:@"query"] valueForKey:@"results"] valueForKey:@"channel"]valueForKey:@"wind"] valueForKey:@"speed"] floatValue];

    
    
    
    degreesValue = (([temp intValue] - 32) / 1.8000);
    humidityValue = humidity;
    windValue = wind * 1.609344;
    
    [self updateLables];
    
    
    float windAnimationSpeed  = windValue * 0.6;
    
    [self runSpinAnimationOnView:windImageView duration:1 rotations:windAnimationSpeed repeat:HUGE_VALL];
    
}

-(void)updateLables
{
    
    [UIView animateWithDuration:1 animations:^
    {
        degreesLable.alpha = 0;
        windLable.alpha =0;
        windImageView.alpha = 0;
        addressLable.alpha = 0;

    }
    completion:^(BOOL finished)
    {
        
        degreesLable.text = [NSString stringWithFormat:@"%0.1f %@",degreesValue,@"\u00B0"];
        windLable.text = [NSString stringWithFormat:@"%0.1f Mph",windValue];
        addressLable.text = addressValue;

        [UIView animateWithDuration:1 animations:^
        {
            
            degreesLable.alpha = 1;
            windLable.alpha =1;
            windImageView.alpha = 1;
            addressLable.alpha = 1;


        }];
    }];
}

-(void)setLables
{
    
    CGFloat addressLable_x_Pos = self.view.frame.size.width * 0.03;
    CGFloat addressLable_y_Pos = self.view.frame.size.height * 0.03;
    CGFloat addressLable_width = self.view.frame.size.width * 0.5;
    CGFloat addressLable_height = self.view.frame.size.height * 0.15;
    CGFloat addressLable_fontSize = self.view.frame.size.height * 0.03;
    
    
    addressLable = [[UILabel alloc]initWithFrame:CGRectMake(addressLable_x_Pos, addressLable_y_Pos, addressLable_width, addressLable_height)];
    //    degreesLable.backgroundColor = [UIColor greenColor];
    addressLable.text = addressValue;
    addressLable.font = [UIFont fontWithName:@"Arial" size:addressLable_fontSize];
    addressLable.numberOfLines = 2;
    addressLable.textColor = [UIColor whiteColor];
    addressLable.textAlignment = NSTextAlignmentCenter;
    addressLable.alpha = 0;
    [self.view addSubview:addressLable];

    
    
    CGFloat x_Pos = self.view.frame.size.width * 0.05;
    CGFloat y_Pos = CGRectGetMaxY(addressLable.frame);
    CGFloat degreesLable_width = self.view.frame.size.width * 0.5;
    CGFloat degreesLable_height = self.view.frame.size.height * 0.15;
    CGFloat degreesLable_fontSize = self.view.frame.size.height * 0.1;

    
    degreesLable = [[UILabel alloc]initWithFrame:CGRectMake(x_Pos, y_Pos, degreesLable_width, degreesLable_height)];
//    degreesLable.backgroundColor = [UIColor greenColor];
    degreesLable.text = [NSString stringWithFormat:@"%0.1f %@",degreesValue,  @"\u00B0"];
    degreesLable.font = [UIFont fontWithName:@"Arial" size:degreesLable_fontSize];
    degreesLable.textColor = [UIColor whiteColor];
    degreesLable.textAlignment = NSTextAlignmentCenter;
    degreesLable.alpha =0;
    [self.view addSubview:degreesLable];
    
    
    CGFloat space_x = self.view.frame.size.width * 0.06;
    CGFloat windLable_x_Pos = CGRectGetMaxX(degreesLable.frame) + space_x;
    CGFloat windLable_y_Pos = self.view.frame.size.height * 0.2;
    CGFloat windLable_width = self.view.frame.size.width * 0.35;
    CGFloat windLable_height = self.view.frame.size.height * 0.06;
    CGFloat windLable_fontSize = self.view.frame.size.height * 0.04;
    
    windLable = [[UILabel alloc]initWithFrame:CGRectMake(windLable_x_Pos, windLable_y_Pos, windLable_width, windLable_height)];
    windLable.text = [NSString stringWithFormat:@"%0.1f Mph",windValue];
    windLable.font = [UIFont fontWithName:@"Arial" size:windLable_fontSize];
    windLable.textColor = [UIColor whiteColor];
    windLable.textAlignment = NSTextAlignmentCenter;
    windLable.alpha =0;

    [self.view addSubview:windLable];
    
    CGFloat space_y = self.view.frame.size.height * 0.03;

    CGFloat windImageView_x_Pos = windLable.frame.origin.x;
    CGFloat windImageView_y_Pos = CGRectGetMaxY(windLable.frame) + space_y;
    CGFloat windImageView_size = windLable.frame.size.width * 0.8;

    windImageView = [[UIImageView alloc]initWithFrame:CGRectMake(windImageView_x_Pos, windImageView_y_Pos, windImageView_size, windImageView_size)];
    windImageView.center = CGPointMake(windLable.center.x, windImageView.center.y);
    windImageView.alpha =0;
    [windImageView setImage:[UIImage imageNamed:@"Fan.png"]];
    
//    windImageView.backgroundColor =[UIColor greenColor];
    
    
    
    [self.view addSubview:windImageView];
    
    
}



- (void)runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
