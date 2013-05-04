//
//  Contact.m
//  ABook
//
//  Created by georg chimion on 5/3/13.
//  Copyright (c) 2013 georgchimion. All rights reserved.
//

#import "Contact.h"

@implementation Contact

@synthesize firstname, lastname, age;

-(id)initWithDetails:(NSString*)first last:(NSString*)last yrs:(int)yrs
{
    self.firstname = first;
    self.lastname = last;
    self.age = [NSNumber numberWithInt:yrs];
    
    return self;
}

@end
