//
//  IMSExpDatePickerDataSource.m
//  CrazyGoats
//
//  Created by Max on 08.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "IMSExpDatePickerDataSource.h"

@interface IMSExpDatePickerDataSource () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) NSInteger currentYear;

@end

@implementation IMSExpDatePickerDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDateFormatter * dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yy"];
        
        self.currentYear = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
    }
    return self;
}

- (void)setPickerView:(UIPickerView *)pickerView
{
    _pickerView = pickerView;
    pickerView.delegate = self;
    pickerView.dataSource = self;
}


#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataProvider numberOfItemsInSection:component];
}


#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component) {
        return [NSString stringWithFormat:@"%li", self.currentYear + row];
    }
    
    return [self.dataProvider itemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:component]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger fisrtSelectedIndex = [self.pickerView selectedRowInComponent:0];
    NSInteger secondSelectedIndex = [self.pickerView selectedRowInComponent:1];
    NSMutableString *item = [NSMutableString new];
    
    if (fisrtSelectedIndex > -1) {
        [item appendString:[self pickerView:pickerView titleForRow:fisrtSelectedIndex forComponent:0]];
    }
    
    if (secondSelectedIndex > -1) {
        [item appendFormat:@"/%@", [self pickerView:pickerView titleForRow:secondSelectedIndex forComponent:1]];
    }
    
    if ([self.delegate respondsToSelector:@selector(expDatePickerDataSource:didSelectItem:)]) {
        [self.delegate expDatePickerDataSource:self didSelectItem:item];
    }
}


@end
