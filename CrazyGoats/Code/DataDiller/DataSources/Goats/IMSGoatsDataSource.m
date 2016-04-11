//
//  IMSGoatsDataSource.m
//  CrazyGoats
//
//  Created by Max on 06.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "IMSGoatsDataSource.h"
#import "IMSGoatCell.h"


@implementation IMSGoatsDataSource

- (Class)classForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return [IMSGoatCell class];
}

@end
