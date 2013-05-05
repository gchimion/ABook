//
//  ContactDetailsViewController.h
//  ABook
//
//  Created by georg chimion on 5/3/13.
//  Copyright (c) 2013 georgchimion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol ContactDetailsProtocol <NSObject>
-(void)contactDetailsWereChanged;
-(void)contactHasBeenDeleted:(Contact *) contactToDelete;
-(void)contactHasBeenCreated:(Contact *) contactToDelete;
@end

@interface ContactDetailsViewController : UIViewController

@property (strong, nonatomic) Contact *displayedContact;

@property (strong, nonatomic) id<ContactDetailsProtocol> delegate;

@property (nonatomic, assign) BOOL isNewContact;

@end
