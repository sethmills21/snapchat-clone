//
//  PickRecipientTableViewController.m
//  ghostChat
//
//  Created by Seth Miller on 7/9/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "PickRecipientTableViewController.h"
#import "CreateMessageViewController.h"

@import Firebase;

@interface PickRecipientTableViewController ()

@property NSMutableArray *recipientsArray;

@end

@implementation PickRecipientTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self getRecipients];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getRecipients {
	FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
	
	FIRDatabaseQuery *userQuery = [databaseRef child:@"users"];
	
	FIRDatabaseReference *ref = userQuery.ref;
	
	[ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
		
		NSDictionary *dict = snapshot.value;
		NSString *key = snapshot.key;
		
		self.recipientsArray = [[NSMutableArray alloc] init];
		
		self.recipientsArray = [[dict allValues] mutableCopy];
		
		[self.tableView reloadData];
		
		NSLog(@"key = %@ for child %@", key, dict);
	}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.recipientsArray == nil) {
		return 1;
	}
	
	return self.recipientsArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (self.recipientsArray == nil || self.recipientsArray.count == 0) {
		return;
	}
	
	[self performSegueWithIdentifier:@"pushToMessageViewController" sender:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipientCell" forIndexPath:indexPath];
	
	//check if we're loading recipients
	
	if (self.recipientsArray == nil) {
		cell.textLabel.text = @"Loading";
		cell.textLabel.textAlignment = NSTextAlignmentCenter;
		cell.accessoryType = UITableViewCellAccessoryNone;
		return cell;
	}
	
	//check if there are zero users
	
	if (self.recipientsArray.count == 0) {
		cell.textLabel.text = @"Sorry, there are no users to send a message to :(";
		cell.textLabel.textAlignment = NSTextAlignmentCenter;
		cell.accessoryType = UITableViewCellAccessoryNone;
		return cell;
	}
	
	NSDictionary *recipientInfo = [self.recipientsArray objectAtIndex:indexPath.row];
	
	cell.textLabel.textAlignment = NSTextAlignmentLeft;
	
	cell.textLabel.text = [recipientInfo objectForKey:@"username"];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"pushToMessageViewController"] == YES) {
		CreateMessageViewController *messageViewController = (CreateMessageViewController *)segue.destinationViewController;
		
		messageViewController.recipientInfo = [self.recipientsArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
	}
}


@end
