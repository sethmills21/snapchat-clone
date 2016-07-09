//
//  PickRecipientTableViewController.m
//  ghostChat
//
//  Created by Seth Miller on 7/9/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "PickRecipientTableViewController.h"
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipientCell" forIndexPath:indexPath];
	
	//check if we're loading recipients
	
	if (self.recipientsArray == nil) {
		cell.textLabel.text = @"Loading";
		cell.textLabel.textAlignment = NSTextAlignmentLeft;
		cell.accessoryType = UITableViewCellAccessoryNone;
		return cell;
	}
	
	//check if there are zero users
	
	if (self.recipientsArray.count == 0) {
		cell.textLabel.text = @"Sorry, there are no users to send a message to :(";
		cell.accessoryType = UITableViewCellAccessoryNone;
		return cell;
	}
	
	NSDictionary *recipientInfo = [self.recipientsArray objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [recipientInfo objectForKey:@"username"];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
