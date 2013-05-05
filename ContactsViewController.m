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

@interface ContactsViewController ()  <ContactDetailsProtocol>
@property (nonatomic, strong) NSMutableArray    *contactsArray;
@property (nonatomic, assign) BOOL NewContactPressed;

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
- (IBAction)NewContactPressed:(id)sender {
    self.NewContactPressed = true;
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [self contactHasBeenDeleted:[self.contactsArray objectAtIndex:indexPath.row]];
    }
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    // parent is nil if this view controller was removed
    self.NewContactPressed = false;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.NewContactPressed = false;
    
    self.contactsArray = [NSMutableArray array];
    [self.contactsArray addObject:[[Contact alloc] initWithDetails:@"jon" last:@"bensamoun" yrs:32]];
    [self.contactsArray addObject:[[Contact alloc] initWithDetails:@"georg" last:@"chimion" yrs:33]];
    [self.contactsArray addObject:[[Contact alloc] initWithDetails:@"ian" last:@"king" yrs:34]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactHasBeenDeleted:)
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
    [destinationVC setDelegate:self];
    
    if (self.NewContactPressed)
    {
 
        [destinationVC setIsNewContact:true];
    }
    else
    {
        [destinationVC setIsNewContact:false];
    }

        [destinationVC setDisplayedContact:[self.contactsArray objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
}


#pragma mark - ContactDetailsProtocol

-(void)contactDetailsWereChanged
{
    [self.tableView reloadData];
}

-(void)contactHasBeenDeleted:(Contact *) contactToDelete
{
    //Contact * contactToDelete = notification.object;
    
    [self.contactsArray removeObject:contactToDelete];
    
    [self.tableView reloadData];
}

-(void)contactHasBeenCreated:(Contact *) contactToCreate
{
    [self.contactsArray addObject:contactToCreate];
    
    [self.tableView reloadData];
}



@end
