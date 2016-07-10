//
//  CreateMessageViewController.m
//  ghostChat
//
//  Created by Seth Miller on 7/3/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "CreateMessageViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@import Firebase;

@interface CreateMessageViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *messageImageView;
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendMessageButton;

@end

@implementation CreateMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UITapGestureRecognizer *tapPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePicture)];
	
	self.messageImageView.userInteractionEnabled = YES;
	[self.messageImageView addGestureRecognizer:tapPicture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)saveMessageToFirebase {
	FIRUser *currentUser = [FIRAuth auth].currentUser;
	
	FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
	
	NSString *key = [[databaseRef child:@"messages"] childByAutoId].key;
	
	[self uploadImageToFirebase:key];
	
	NSMutableDictionary *message = [[NSMutableDictionary alloc] init];
	
	[message setValue:currentUser.uid forKey:@"sender"];
	[message setValue:currentUser.displayName forKey:@"senderUsername"];
	[message setValue:self.messageTextField.text forKey:@"messageText"];
	
	NSString *messagePathString = [NSString stringWithFormat:@"/messages/%@/", self.recipientInfo[@"uid"]];
	
	NSDictionary *childUpdates = @{[messagePathString stringByAppendingString:key] : message};
	
	[databaseRef updateChildValues:childUpdates];
}

- (void)uploadImageToFirebase:(NSString *)key {
	FIRStorageReference *storageRef = [[FIRStorage storage] reference];
	
	NSString *imagesPath = [NSString stringWithFormat:@"/images/%@", key];
	
	FIRStorageReference *imagesRef = [storageRef child:imagesPath];
	
	NSData *imageData = UIImageJPEGRepresentation(self.messageImageView.image, 0.5);
	
	FIRStorageMetadata *metadata = [FIRStorageMetadata new];
	metadata.contentType = @"image/jpeg";
	
	[imagesRef putData:imageData metadata:metadata completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
		if (error != nil) {
			NSLog(@"error %@", error);
			return;
		}
		
		NSLog(@"success! metadata %@", metadata);
			
	}];
}

- (IBAction)sendAction:(id)sender {
	[self saveMessageToFirebase];
}

- (void)choosePicture {
	[self chooseMessagePicture];
}

#pragma mark - image view picker code

- (void)chooseMessagePicture {
	BOOL hasPhotoLibrary = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
	BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
	
	if (hasPhotoLibrary == NO && hasCamera == NO)
		return;
	
	if (hasPhotoLibrary == YES || hasCamera == YES) {
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose Picture" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
		
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
		
		if (hasCamera == YES) {
			
			UIAlertAction *useCameraAction = [UIAlertAction actionWithTitle:@"From Camera"
																	  style:UIAlertActionStyleDefault
																	handler:^(UIAlertAction *action) {
																		[self presentImagePickerUsingCamera:YES];
																	}];
			
			[alertController addAction:useCameraAction];
			
		}
		
		UIAlertAction *usePhotosAction = [UIAlertAction
										  actionWithTitle:@"From Photos"
										  style:UIAlertActionStyleDefault
										  handler:^(UIAlertAction *action) {
											  [self presentImagePickerUsingCamera:NO];
										  }];
		
		[alertController addAction:cancelAction];
		[alertController addAction:usePhotosAction];
		
		[self presentViewController:alertController animated:YES completion:nil];
	}
}

- (void)presentImagePickerUsingCamera:(BOOL)useCamera {
	UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
	
	if (useCamera == YES) {
		pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
	} else {
		pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}
	pickerController.mediaTypes = @[(NSString*)kUTTypeImage];
	
	pickerController.delegate = (id <UINavigationControllerDelegate, UIImagePickerControllerDelegate>)self;
	[self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[self dismissImagePicker];
	
	NSString *mediaType = info[UIImagePickerControllerMediaType];
	
	if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
		UIImage *image = info[UIImagePickerControllerOriginalImage];
		
		self.messageImageView.image = [self scaleImage:image toSize:self.messageImageView.frame.size];
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissImagePicker];
}

- (void)dismissImagePicker {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
	CGSize actSize = image.size;
	float scale = actSize.width/actSize.height;
	
	if (scale < 1) {
		newSize.height = newSize.width/scale;
	} else {
		newSize.width = newSize.height*scale;
	}
	
	
	UIGraphicsBeginImageContext(newSize);
	[image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}


@end
