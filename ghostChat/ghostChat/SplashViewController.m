//
//  SplashViewController.m
//  ghostChat
//
//  Created by Seth Miller on 6/25/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)loginAction:(id)sender {
	NSLog(@"testing login method");
	
}

- (IBAction)signupAction:(id)sender {
	NSLog(@"testing signup method");
}

@end
