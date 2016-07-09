//
//  HomeTableViewController.m
//  ghostChat
//
//  Created by Seth Miller on 7/3/16.
//  Copyright © 2016 SethMiller. All rights reserved.
//

#import "HomeTableViewController.h"
@import Firebase;

@interface HomeTableViewController ()

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	//[self loadFirebaseDB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFirebaseDB {
	FIRUser *currentUser = [FIRAuth auth].currentUser;
	
	FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
	
	NSString *key = [[databaseRef child:@"messages"] childByAutoId].key;
	NSDictionary *message = @{@"uid": currentUser.uid,
						   @"recipient": currentUser.uid,
						   @"title": @"test"};
	
	NSDictionary *childUpdates = @{[@"/messages/" stringByAppendingString:key]: message, [NSString stringWithFormat:@"/user-messages/%@/%@", currentUser.uid, key] : message};
	
	[databaseRef updateChildValues:childUpdates];
	
	[self getMessages];
}

- (void)getMessages {
	NSString *userID = [FIRAuth auth].currentUser.uid;
	
	FIRDatabaseReference *databaseRef = [[FIRDatabase database] reference];
	
	FIRDatabaseQuery *messagesQuery = [[databaseRef child:@"user-messages"]
										  child:userID];
	
	NSLog(@"my top posts query %@", messagesQuery.ref);
	
	FIRDatabaseReference *ref = messagesQuery.ref;
	
	[ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
		
		NSDictionary *dict = snapshot.value;
		NSString *key = snapshot.key;
		
		NSLog(@"key = %@ for child %@", key, dict);
	}];

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
