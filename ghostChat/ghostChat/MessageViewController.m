//
//  MessageViewController.m
//  ghostChat
//
//  Created by Seth Miller on 7/10/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "MessageViewController.h"
@import Firebase;

@interface MessageViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *messageImageView;
@property (strong, nonatomic) IBOutlet UILabel *fromLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageTextLabel;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupInterface {
	self.messageTextLabel.text = [self.messageInfo objectForKey:@"messageText"];
	self.fromLabel.text = [NSString stringWithFormat:@"From: %@", [self.messageInfo objectForKey:@"senderUsername"]];
	
	[self getImageFromFirebase];
	
}

- (void)getImageFromFirebase {
	FIRStorageReference *storageRef = [[FIRStorage storage] reference];
	
	NSString *imagesPath = [NSString stringWithFormat:@"/images/%@", self.messageKey];
	
	FIRStorageReference *imagesRef = [storageRef child:imagesPath];
	
	[imagesRef dataWithMaxSize:5 * 1024 * 1024 completion:^(NSData *data, NSError *error) {
		if (error != nil) {
			NSLog(@"error downloading image %@", error);
		} else {
			self.messageImageView.image = [UIImage imageWithData:data];
		}
	}];
}

@end
