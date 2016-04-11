//
//  IMSGoatsDataProvider.m
//  CrazyGoats
//
//  Created by Max on 06.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "IMSGoatsDataProvider.h"
#import "IMSGoat.h"


@implementation IMSGoatsDataProvider

- (void)initialConfigure
{
    [super initialConfigure];
    self.items = [self goatsFromJSON];
}


#pragma mark -
#pragma mark Help Methods

- (NSArray *)goatsFromJSON
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Goats" ofType:@"json"];
    
    NSData *jsonData =  [NSData dataWithContentsOfFile:filePath];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray *goats = [[NSMutableArray alloc] initWithCapacity:jsonArray.count];
    for (NSDictionary *dict in jsonArray) {
        IMSGoat *goat = [IMSGoat goatForUID:dict[IMSGoatKeys.uid]
                                       name:dict[IMSGoatKeys.name]
                                      price:dict[IMSGoatKeys.price]
                                  photoName:dict[IMSGoatKeys.photoName]];
        [goats addObject:goat];
    }
    
    return goats;
}

@end
