//
//  IMSGoat.m
//  CrazyGoats
//
//  Created by Max on 06.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "IMSGoat.h"

@implementation IMSGoat

+ (instancetype)goatForUID:(NSNumber *)uid name:(NSString *)name price:(NSNumber *)price photoName:(NSString *)photoName
{
    IMSGoat *goat = [IMSGoat new];
    goat.uid = uid;
    goat.name = name;
    goat.price = price;
    goat.photoName = photoName;
    return goat;
}

- (NSString *)priceString
{
    return [@"$" stringByAppendingString:[NSString stringWithFormat:@"%.2f", self.price.floatValue]];
}

@end
