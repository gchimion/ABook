//
//  ContactsViewController.m
//  ABook
//
//  Created by georg chimion on 5/3/13.
//  Copyright (c) 2013 georgchimion. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactDetailsViewController.h"
#import "Contact.h"

@interface ContactsViewController ()  // <ContactDetailsProtocol>
@property (nonatomic, strong) NSMutableArray    *contactsArray;
@end

@implementation ContactsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contactsArray = [NSMutableArray array];
    [self.contactsArray addObject:[[Contact alloc] initWithDetails:@"jon" last:@"bensamoun" yrs:32]];
    [self.contactsArray addObject:[[Contact alloc] initWithDetails:@"georg" last:@"chimion" yrs:33]];
    [self.contactsArray addObject:[[Contact alloc] initWithDetails:@"ian" last:@"king" yrs:34]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactHasBeenDeleted)
                                                 name:@"HEY_DELETE_CONTACT" object:nil];
    

    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactDetailsWereChanged)
                                                 name:@"HEY_RELOAD_TABLE" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contactsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Contact *contact = [self.contactsArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@ (%@)", contact.firstname, contact.lastname, contact.age]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    ContactDetailsViewController *destinationVC = [segue destinationViewController];
//    [destinationVC setDelegate:self];
    [destinationVC setDisplayedContact:[self.contactsArray objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
}


#pragma mark - ContactDetailsProtocol

-(void)contactDetailsWereChanged
{
    [self.tableView reloadData];
}

-(void)contactHasBeenDeleted:(NSNotification*) notification
{
    Contact * contactToDelete = [[notification userInfo] valueForKey:@"contactToDelete"];
    
    [self.contactsArray removeObjectIdenticalTo: contactToDelete];
    
    [self.tableView reloadData];
}





@end
