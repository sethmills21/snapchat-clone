//
//  SplashViewController.m
//  ghostChat
//
//  Created by Seth Miller on 6/25/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "SplashViewController.h"
@import QuartzCore;

@interface SplashViewController ()

@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.signUpButton.clipsToBounds = YES;
	self.signUpButton.layer.cornerRadius = self.signUpButton.frame.size.height/2;
	self.signUpButton.layer.borderWidth = 2;
	self.signUpButton.layer.borderColor = [UIColor whiteColor].CGColor;
	
	self.loginButton.clipsToBounds = YES;
	self.loginButton.layer.cornerRadius = self.signUpButton.frame.size.height/2;
	self.loginButton.layer.borderWidth = 2;
	self.loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
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
