//
//  C4QColorPickerViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QColorPickerViewController.h"

@interface C4QColorPickerViewController ()


@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;

@property (nonatomic) UIColor *currentColor;


@end

@implementation C4QColorPickerViewController

- (IBAction)redColor:(id)sender {
    [self.delegate userDidPickColor:@"red"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)greenColor:(id)sender {
    [self.delegate userDidPickColor:@"green"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)blueColor:(id)sender {
    [self.delegate userDidPickColor:@"blue"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueButton.backgroundColor = [UIColor blueColor];
    self.greenButton.backgroundColor = [UIColor greenColor];
    self.redButton.backgroundColor = [UIColor redColor];
}

@end
