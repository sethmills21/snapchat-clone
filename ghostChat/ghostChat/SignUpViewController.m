//
//  SignUpViewController.m
//  ghostChat
//
//  Created by Seth Miller on 6/25/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "SignUpViewController.h"
@import Firebase;

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
	if (self.emailTextField.text.length > 0 && self.passwordTextField.text.length > 0 && self.usernameTextField.text.length > 0) {
		
		[self signupUserWithEmail:self.emailTextField.text password:self.passwordTextField.text username:self.usernameTextField.text];
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

- (void)signupUserWithEmail:(NSString *)email password:(NSString *)password username:(NSString *)username {
	//start a loading indicator
	
	[[FIRAuth auth]
	 createUserWithEmail:email
	 password:password
	 completion:^(FIRUser *_Nullable user,
				  NSError *_Nullable error) {
		 
		 NSLog(@"user %@ error %@", user, error);
		 
		 if (error != nil) {
			 FIRUser *currentUser = [FIRAuth auth].currentUser;
			 
			 FIRUserProfileChangeRequest *changeRequest = [currentUser profileChangeRequest];
			 
			 changeRequest.displayName = username;

			 [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
				
				 if (error) {
					 NSLog(@"error %@", error.localizedDescription);
					 // An error happened.
				 } else {
					 // Profile updated.
				 }
			 }];
			 
			 //account created
		 } else {
			 //return and show an error
		 }
		 
		 //finish loading indicator
		
	 }];
}



@end
