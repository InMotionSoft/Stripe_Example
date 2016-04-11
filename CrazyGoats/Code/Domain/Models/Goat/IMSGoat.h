//
//  IMSGoat.h
//  CrazyGoats
//
//  Created by Max on 06.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMSGoat : NSObject

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *photoName;

+ (instancetype)goatForUID:(NSNumber *)uid name:(NSString *)name price:(NSNumber *)price photoName:(NSString *)photoName;

- (NSString *)priceString;

@end
