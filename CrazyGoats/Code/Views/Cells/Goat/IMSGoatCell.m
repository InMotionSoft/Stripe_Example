//
//  IMSGoatCell.m
//  CrazyGoats
//
//  Created by Max on 06.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "IMSGoatCell.h"

@interface IMSGoatCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *goatNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goatPriceLabel;

@end

@implementation IMSGoatCell

- (void)fillWithObject:(IMSGoat *)domainObject
{
    self.photoImageView.image = [UIImage imageNamed:domainObject.photoName];
    self.goatNameLabel.text = domainObject.name;
    self.goatPriceLabel.text = [domainObject priceString];
}

@end
