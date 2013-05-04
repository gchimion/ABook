//
//  ContactDetailsViewController.m
//  ABook
//
//  Created by georg chimion on 5/3/13.
//  Copyright (c) 2013 georgchimion. All rights reserved.
//

#import "ContactDetailsViewController.h"

@interface ContactDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation ContactDetailsViewController

@synthesize displayedContact;
//@synthesize delegate;


- (IBAction)delButtonTapped:(id)sender {
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"HEY_DELETE_CONTACT" object:displayedContact];

    NSDictionary *contactDictionary = [NSDictionary dictionaryWithObject:displayedContact
                      forKey:@"contactToDelete"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HEY_DELETE_CONTACT" object:nil userInfo:contactDictionary];
 
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)saveButtonTapped:(id)sender {
    [self.displayedContact setFirstname:self.firstnameTextField.text];
    [self.displayedContact setLastname:self.lastnameTextField.text];
    [self.displayedContact setAge:[NSNumber numberWithInt:[self.ageTextField.text intValue]]];
    
//    [self.delegate contactDetailsWereChanged];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HEY_RELOAD_TABLE" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.firstnameTextField setText:self.displayedContact.firstname];
    [self.lastnameTextField setText:self.displayedContact.lastname];
    [self.ageTextField setText:[self.displayedContact.age stringValue]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
