//
//  MessageViewController.h
//  ghostChat
//
//  Created by Seth Miller on 7/10/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController

@property (strong, nonatomic) NSDictionary *messageInfo;
@property (strong, nonatomic) NSString *messageKey;

@end
