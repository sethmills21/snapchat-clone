//
//  LoginViewController.m
//  ghostChat
//
//  Created by Seth Miller on 7/3/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "LoginViewController.h"
@import Firebase;

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submitAction:(id)sender {
	[self signinWithEmail];
	
	self.loginButton.clipsToBounds = YES;
	self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height/2;
	self.loginButton.layer.borderWidth = 2;
	self.loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)signinWithEmail {
	[[FIRAuth auth] signInWithEmail:self.emailTextField.text
						   password:self.passwordTextField.text
						 completion:^(FIRUser *user, NSError *error) {
							 if (error != nil) {
								 [self showAlertController];
							 } else {
								 [self performSegueWithIdentifier:@"pushToInboxFromLogin" sender:self];
							 }
						 }];
}

- (void)showAlertController {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"Invalid credentials" preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
	
	[alertController addAction:okAction];

	[self presentViewController:alertController animated:YES completion:nil];
}


@end
