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

@end
