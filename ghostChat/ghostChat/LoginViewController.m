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
}

- (void)signinWithEmail {
	[[FIRAuth auth] signInWithEmail:self.emailTextField.text
						   password:self.passwordTextField.text
						 completion:^(FIRUser *user, NSError *error) {
							 if (error != nil) {
								 NSLog(@"successful login!");
							 } else {
								 NSLog(@"error %@", error.localizedDescription);
							 }
						 }];
}


@end
