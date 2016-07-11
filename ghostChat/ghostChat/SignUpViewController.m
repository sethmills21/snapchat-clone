//
//  SignUpViewController.m
//  ghostChat
//
//  Created by Seth Miller on 6/25/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "SignUpViewController.h"
@import Firebase;
@import QuartzCore;

@interface SignUpViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.submitButton.clipsToBounds = YES;
	self.submitButton.layer.cornerRadius = self.submitButton.frame.size.height/2;
	self.submitButton.layer.borderWidth = 2;
	self.submitButton.layer.borderColor = [UIColor whiteColor].CGColor;
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
	[[FIRAuth auth]
	 createUserWithEmail:email
	 password:password
	 completion:^(FIRUser *_Nullable user,
				  NSError *_Nullable error) {
		 
		 NSLog(@"user %@ error %@", user, error);
		 
		 if (error == nil) {
			 FIRUser *currentUser = [FIRAuth auth].currentUser;
			 
			 FIRUserProfileChangeRequest *changeRequest = [currentUser profileChangeRequest];
			 
			 changeRequest.displayName = username;
			 
			 FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
			 
			 FIRDatabaseReference *usersRef = [[databaseRef child:@"users"] child:currentUser.uid];
			 
			 NSDictionary *userInfo = @{@"uid": currentUser.uid,
										@"username": username};
			 
			 [usersRef setValue:userInfo];

			 [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
				
				 if (error) {
					 NSLog(@"error %@", error.localizedDescription);
				} else {
					 [self performSegueWithIdentifier:@"pushToInboxFromSignup" sender:self];
				}
			 }];
		 } else {
			 [self showAlertController:error.localizedDescription];
		 }
		 		
	 }];
}

- (void)showAlertController:(NSString *)errorMessage {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
	
	[alertController addAction:okAction];
	
	[self presentViewController:alertController animated:YES completion:nil];
}



@end
