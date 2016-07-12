<a href="https://codeupstart.com">
    <img src="https://s32.postimg.org/gzi5dekhh/ghost_chat_icon_web.png" alt="Ghostchat Icon" title="Ghost" align="center" height="114" width="114"/>
</a>

# Ghostchat - a Snapchat clone

An iOS snapchat clone developed in Objective-C that leverages Firebase as a backend. This is the documentation for the CodeUpStart course which can you find here. The course guides student from start to finish on how to create an app like Snapchat regardless of your coding expertise! 

## Table of contents

- [Course Info](#course-info)
- [Student Resources](#student-resources)
    - [Full Source Code](#source-code) 
    - [Image Picker Code](#image-picker-code) 
    - [Add Done Button to Keyboard](#add-done-button-to-keyboard)
- [More Resources](#awesome-resources)
- [Connect with the Instructor](#connect-with-the-instructor)

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

## More Resources 

These are some resources that I've found super helpful while developing several different iOS projects. Figured it'd be worth sharing for reference when you go to build your own apps!

Nice tools

* [LaunchKit](https://launchkit.io/screenshots/) - LaunchKit helps you easily create beautiful app store screenshot images. LaunchKit can also help you montior reviews.

* [MakeAppIcon](https://makeappicon.com/) - I referenced this tool in one of the course videos. MakeAppIcon will automatically slice and dice your app icon image asset to iOS and even Android's specs

Analytics

* [Amplitude](https://amplitude.com/settings/) - Currently my favorite analytics platform. It's free and comes with everything you need. However, if you're going to leverage Firebase for your apps - they also have an [analytics tool](https://firebase.google.com/docs/analytics/) that you'd most likely want to use instead. Analytics is a CLUTCH part of app building so make sure to read up on mobile growth / analytics. 

* [ARRRR Analytics Framework](http://www.slideshare.net/dmc500hats/startup-metrics-for-pirates-long-version) - If you're not familiar with analytics or how to track meaningful user behavior, this is a great place to start as it's one of the most widely used and accepted growth frameworks in the game. 

Libraries 

* [AFNetworking](https://github.com/AFNetworking/AFNetworking) - One of the greatest libraries ever created, AFNetworking will make all your networking (HTTP POSTS, GETS, etc) operations stupid simple.

* [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager) - Remember that video when I mentioned the issues you can run into when the keyboard shows? Well, you can drop this library in your project and it will take care all fo that. You don't need even need to write any code, it works automatically (note, that almost always things that sound like this never pan out that way but this library has 6,000+ stars so safe to say it's verified). I've also used it before and can vouch for it. 

* [PageMenu](https://github.com/HighBay/PageMenu) - Easily create "paging" menus that hold view controllers so you can swipe through them.

* [TTRangeSlider](https://github.com/TomThorpe/TTRangeSlider) - A handy slider similar to UISlider that lets you pick min/max ranges (easy to customize too)

Good places to score knowledge on product/growth/apps/startups

* [GrowthHackers](https://growthhackers.com/) - a reddit/hackernews style community of growth people posting articles, learnings, etc. They also just launched a really cool called Projects. 

* [Growth Bug Medium Publication](https://growthbug.com/?source=search_collection) - medium publication with lots of good posts on mobile

* [Mobile Growth Medium Publication](https://medium.com/mobile-growth) - another great pub on Medium that features app developers and product managers learnings

* [Greylock Partners Medium Publication](https://news.greylock.com/the-hierarchy-of-engagement-5803bf4e6cfa#.7tc7riuxh) - linked to a specific post in Greylock's publication from Sarah Tavel, a partner there that outlines a concept called the 'The Hierarchy of Engagement' that's pretty awesome. Josh Elman, another partner @ Greylock is also a good name to google for content as he lead growth @ various startups like LinkedIn and Twitter.

* [Andrew Chen's Blog](http://andrewchen.co/) - legendary essays on product, growth, etc. 

* [Paul Graham's Blog](http://paulgraham.com/) - more legendary essays

## Connect with the Instructor
*email - seth@rapchat.me
*[twitter](https://twitter.com/@sethmills21)