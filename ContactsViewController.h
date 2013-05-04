//
//  ContactsViewController.h
//  ABook
//
//  Created by georg chimion on 5/3/13.
//  Copyright (c) 2013 georgchimion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UITableViewController

-(void)contactDetailsWereChanged;

-(void)contactHasBeenDeleted:(NSNotification*) notification;

@end
