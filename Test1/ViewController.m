//
//  ViewController.m
//  Test1
//
//  Created by Roee Nadam on 12/21/15.
//  Copyright © 2015 Nadam. All rights reserved.
//

#import "ViewController.h"
#import "YQL.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Download the following GitHub repository https://github.com/guilhermechapiewski/yql-ios
    // Copy the yql-ios folder to your project
    
    YQL *yql = [[YQL alloc] init];
    NSString *queryString = @"select * from weather.forecast where woeid=1968212";
    NSDictionary *results = [yql query:queryString];
    NSLog(@"%@",results[@"query"][@"count"]);
    NSLog(@"%@",results[@"query"][@"results"]);
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)AddShineAnimationToView:(UIView*)aView
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setStartPoint:CGPointMake(0, 0)];
    [gradient setEndPoint:CGPointMake(1, 0)];
    gradient.frame = CGRectMake(0, 0, aView.bounds.size.width*3, aView.bounds.size.height);
    float lowerAlpha = 0.5;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithWhite:1 alpha:1.0] CGColor],
                       (id)[[UIColor colorWithWhite:1 alpha:lowerAlpha] CGColor],
                       (id)[[UIColor colorWithWhite:1 alpha:1.0] CGColor],
                       
                       nil];
    gradient.locations = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:0.5],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    theAnimation.duration = 1;
    theAnimation.autoreverses = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:-aView.frame.size.width*2];
    theAnimation.toValue = [NSNumber numberWithFloat:0];
    theAnimation.repeatCount = 2;
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.removedOnCompletion = YES;
    [gradient addAnimation:theAnimation forKey:@"animateLayer"];
    aView.layer.mask = gradient;
}


@end
