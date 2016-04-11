//
//  ViewController.m
//  CrazyGoats
//
//  Created by Max on 06.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "ViewController.h"
#import "IMSGoatsDataProvider.h"
#import "IMSGoatsDataSource.h"
#import "IMSGoatDetailsViewController.h"

@import SMDataDiller;


@interface ViewController () <SMDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IMSGoatsDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDataDiller];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kGoatDetailsSegueIdentifier]) {
        ((IMSGoatDetailsViewController *)segue.destinationViewController).goat = sender;
    }
}


#pragma mark -
#pragma mark Configurations

- (void)setupDataDiller
{
    self.dataSource = [[IMSGoatsDataSource alloc] initWithDataProvider:[IMSGoatsDataProvider new] tableView:self.tableView];
    self.dataSource.delegate = self;
    [self.dataSource reload];
}


#pragma mark -
#pragma mark SMDataSourceDelegate

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath withItem:(IMSGoat *)item
{
    [self performSegueWithIdentifier:kGoatDetailsSegueIdentifier sender:item];
}

@end
