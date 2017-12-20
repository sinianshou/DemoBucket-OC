//
//  QSelfNameSetMethod.m
//  DemoBucket-OC
//
//  Created by Easer Liu on 22/11/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//
#import "QSelfNameSetMethod.h"

@implementation QSelfNameSetMethod

-(void)setName:(NSString *)newName
{
    
    NSLog(@"set name");
    self.name = newName;
    NSLog(@"self.name is %@", self.name);
}


@end

