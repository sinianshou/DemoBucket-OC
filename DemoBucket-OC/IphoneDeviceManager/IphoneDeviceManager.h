//
//  IphoneDeviceManager.h
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/26.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IphoneDeviceManager : NSObject

+(instancetype)shared;
- (NSString *)getPlatformString;

@end
