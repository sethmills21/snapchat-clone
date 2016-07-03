//
//  VerifySessionViewController.m
//  ghostChat
//
//  Created by Seth Miller on 7/3/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "VerifySessionViewController.h"
@import Firebase;

@interface VerifySessionViewController ()

@end

@implementation VerifySessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,
													FIRUser *_Nullable user) {
	  if (user != nil) {
		  NSLog(@"send to home view controller we don't have set up yet");
	  } else {
		  [self performSegueWithIdentifier:@"pushToSplashViewSegue" sender:self];
	  }
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
