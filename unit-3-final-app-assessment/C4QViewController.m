//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"
#import "C4QColorPickerViewController.h"

@interface C4QViewController ()<ColorPassingDelegate> 

@end

@implementation C4QViewController

-(void)userDidPickColor:(NSString *)color{
    NSLog(@"%@", color);
    
    if ([color isEqualToString:@"red"]) {
        self.view.backgroundColor = [UIColor redColor];
    }else if
        ([color isEqualToString:@"green"]){
            self.view.backgroundColor = [UIColor greenColor];
        }else if
            ([color isEqualToString:@"blue"]){
                self.view.backgroundColor = [UIColor blueColor];
                
            }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"colorSegue"]) {
        C4QColorPickerViewController *svc = segue.destinationViewController;
        
        svc.delegate = self;
    }
}

@end
