//
//  VerifySessionViewController.m
//  ghostChat
//
//  Created by Seth Miller on 7/3/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "VerifySessionViewController.h"
#import "HomeTableViewController.h"

@import Firebase;

@interface VerifySessionViewController ()

@end

@implementation VerifySessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	
	[[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth,
													FIRUser *_Nullable user) {
	static dispatch_once_t once;
	
		dispatch_once(&once, ^ {
		
		if (user != nil) {
				HomeTableViewController *hometableViewController = [storyboard instantiateViewControllerWithIdentifier:@"homeVC"];
				[self.navigationController setViewControllers:@[hometableViewController] animated:YES];
			} else {
				[self performSegueWithIdentifier:@"pushToSplashViewSegue" sender:self];
			}
					  
		});
		
	}];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
