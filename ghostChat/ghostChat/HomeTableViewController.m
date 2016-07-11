//
//  HomeTableViewController.m
//  ghostChat
//
//  Created by Seth Miller on 7/3/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "HomeTableViewController.h"
#import "MessageViewController.h"
@import Firebase;

@interface HomeTableViewController ()

@property (nonatomic, strong) NSMutableArray *messagesArray;
@property (nonatomic, strong) NSMutableArray *keysArray;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self getMessages];
}

- (void)getMessages {
	NSString *userID = [FIRAuth auth].currentUser.uid;
	
	FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
	
	FIRDatabaseQuery *messagesQuery = [[databaseRef child:@"messages"] child:userID];
	
	FIRDatabaseReference *ref = messagesQuery.ref;
	
	[ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
		NSDictionary *queryResult = snapshot.value;
			
		self.messagesArray = [NSMutableArray array];
		self.messagesArray = [[queryResult allValues] mutableCopy];
		
		self.keysArray = [[queryResult allKeys] mutableCopy];
		
		[self.tableView reloadData];
	}];
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.messagesArray == nil || self.messagesArray.count == 0) {
		return 1;
	}
	
	return self.messagesArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.messagesArray == nil || self.messagesArray.count == 0) {
		return;
	}
	
	[self performSegueWithIdentifier:@"pushToViewMessage" sender:self];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"messageCell"];
	
	//check if we're loading recipients
	
	if (self.messagesArray == nil) {
		cell.textLabel.text = @"Loading";
		cell.textLabel.textAlignment = NSTextAlignmentCenter;
		cell.accessoryType = UITableViewCellAccessoryNone;
		return cell;
	}
	
	//check if there are zero users
	
	if (self.messagesArray.count == 0) {
		cell.textLabel.text = @"Sorry, there are no users to send a message to :(";
		cell.textLabel.textAlignment = NSTextAlignmentCenter;
		cell.accessoryType = UITableViewCellAccessoryNone;
		return cell;
	}
	
	NSDictionary *messageInfo = [self.messagesArray objectAtIndex:indexPath.row];
	
	cell.textLabel.textAlignment = NSTextAlignmentLeft;
	
	cell.textLabel.text = [messageInfo objectForKey:@"messageText"];
	
	cell.detailTextLabel.text = [messageInfo objectForKey:@"senderUsername"];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"pushToViewMessage"] == YES) {
		MessageViewController *messageViewController = (MessageViewController *)segue.destinationViewController;
		
		messageViewController.messageInfo = [self.messagesArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
		messageViewController.messageKey = [self.keysArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
	}
}


@end
