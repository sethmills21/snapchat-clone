<a href="https://codeupstart.com">
    <img src="https://s32.postimg.org/gzi5dekhh/ghost_chat_icon_web.png" alt="Ghostchat Icon" title="Ghost" align="center" height="114" width="114"/>
</a>

# Ghostchat - a Snapchat clone

An iOS snapchat clone developed in Objective-C that leverages Firebase as a backend. This is the final codebase for the CodeUpStart tutorial course which you can find (here).

## Table of contents

- [Course Info](#course-info)
- [Student Resources](#student-resources)
    - [Full Source code](#source-code) 
    - [Image picker code](#image-picker-code) 
    - [Add Done Button to Keyboard](#add-done-button-to-keyboard)
- [License](#license)

## Course Info

## Student Resources

### Source Code

<a href="https://codeupstart.com">
    <img src="https://s31.postimg.org/rhemsn6iz/Screen_Shot_2016_07_12_at_12_44_37_AM.png"/>
</a>

Don't ever play yourself...try and only use the [Source Code](https://google.com) for reference :) 

To run project:
* drag the GoogleService-Info.plist you downloaded from the Firebase websole into the Supporting files folder of the project
* cd to directory of the project and run 'pod install'
* open up the workspace

### Image Picker Code
```objective-c
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
```

### Add 'Done' Button to Keyboard
```objective-c
- (void)addKeyboardToolbar {
	UIToolbar *toolbar = [[UIToolbar alloc] init];
	[toolbar setBarStyle:UIBarStyleDefault];
	[toolbar sizeToFit];

	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
	doneButton.tintColor = [UIColor orangeColor];
	
	UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
	
	NSArray *itemsArray = [NSArray arrayWithObjects:flexButton, doneButton, nil];
	
	[toolbar setItems:itemsArray];
	
	[self.messageTextField setInputAccessoryView:toolbar];
}
```



## License

TODO: Write license