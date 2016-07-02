//
//  SignUpViewController.m
//  ghostChat
//
//  Created by Seth Miller on 6/25/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)submitAction:(id)sender {
	NSDictionary *signupParams = [[NSDictionary alloc] init];
	
	if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0 && self.usernameTextField.text.length > 0) {
		signupParams = @{@"email" : self.emailTextField.text, @"username" : self.usernameTextField.text, @"password" : self.passwordTextField.text};
		
		NSLog(@"signup params %@", signupParams);
		
		//enter firebase code
	} else {
		UIAlertController *alertController = [UIAlertController
											  alertControllerWithTitle:@"Oops"
											  message:@"Please make sure all fields are filled out"
											  preferredStyle:UIAlertControllerStyleAlert];
		
		UIAlertAction *confirmationAction = [UIAlertAction
											 actionWithTitle:@"OK"
											 style:UIAlertActionStyleDefault
											 handler:nil];
		
		[alertController addAction:confirmationAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}





@end
