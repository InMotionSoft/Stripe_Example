//
//  IMSExpDatePickerDataSource.h
//  CrazyGoats
//
//  Created by Max on 08.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@import SMDataDiller.SMBaseDataProvider;


@class IMSExpDatePickerDataSource;
@protocol IMSExpDatePickerDataSourceDelegate <NSObject>

- (void)expDatePickerDataSource:(IMSExpDatePickerDataSource *)dataSource didSelectItem:(NSString *)item;

@end

@interface IMSExpDatePickerDataSource : NSObject

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) SMBaseDataProvider *dataProvider;

@property (nonatomic, weak) id<IMSExpDatePickerDataSourceDelegate> delegate;

@end
