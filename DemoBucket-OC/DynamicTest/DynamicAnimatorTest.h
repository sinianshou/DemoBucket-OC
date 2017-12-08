//
//  DynamicAnimatorTest.h
//  DemoBucket-OC
//
//  Created by Easer Liu on 05/12/2017.
//  Copyright © 2017 Liu Easer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AbsorbDynamicAnimatorType = 0,
    PushDynamicAnimatorType,
    AttachmentDynamicAnimatorType,
    AttachDynamicAnimatorType,
    CollisionDynamicAnimatorType,
} DynamicAnimatorType;

@interface DynamicAnimatorTest : UIViewController

@property (assign, nonatomic) DynamicAnimatorType dynamicAnimatorType;


-(instancetype)initWithDynamicAnimatorType:(DynamicAnimatorType)daType;
-(void)addGravityFunc;
-(void)removeGravityFunc;
@end
