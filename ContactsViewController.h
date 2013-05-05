//
//  ContactsViewController.h
//  ABook
//
//  Created by georg chimion on 5/3/13.
//  Copyright (c) 2013 georgchimion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface ContactsViewController : UITableViewController

-(void)contactDetailsWereChanged;

-(void)contactHasBeenDeleted:(Contact *) contactToDelete;
-(void)contactHasBeenCreated:(Contact *) contactToCreate;

@end
