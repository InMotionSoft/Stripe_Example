//
//  IMSGoatDetailsViewController.m
//  CrazyGoats
//
//  Created by Max on 06.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "IMSGoatDetailsViewController.h"

@interface IMSGoatDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *goatImageView;
@property (weak, nonatomic) IBOutlet UILabel *goatNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation IMSGoatDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fillUI];
}

- (void)fillUI
{
    self.goatImageView.image = [UIImage imageNamed:self.goat.photoName];
    self.goatNameLabel.text = [@"Name: " stringByAppendingString:self.goat.name];
    self.priceLabel.text = [@"Price: " stringByAppendingString:[self.goat priceString]];
}

@end
