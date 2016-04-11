//
//  IMSCustomPaymentViewController.m
//  CrazyGoats
//
//  Created by Max on 08.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "IMSCustomPaymentViewController.h"
#import "IMSExpDatePickerDataSource.h"

@import Stripe;
@import SVProgressHUD;


@interface IMSCustomPaymentViewController () <IMSExpDatePickerDataSourceDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *expirationDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvcNumberTextField;

@property (nonatomic, strong) IMSExpDatePickerDataSource *expDatePickerDataSource;

@end

@implementation IMSCustomPaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupExpDatePickerView];
    
    self.cardParams = [STPCardParams new];
}


#pragma mark -
#pragma mark Configurations

- (void)setupExpDatePickerView
{
    SMBaseDataProvider *dataProvider = [SMBaseDataProvider new];
    dataProvider.items = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"];
    
    UIPickerView *pickerView = [UIPickerView new];
    pickerView.showsSelectionIndicator = YES;
    
    self.expDatePickerDataSource = [IMSExpDatePickerDataSource new];
    self.expDatePickerDataSource.dataProvider = dataProvider;
    self.expDatePickerDataSource.pickerView = pickerView;
    self.expDatePickerDataSource.delegate = self;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(pickerDoneButtonTapped)];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIToolbar *pickerToolbar = [UIToolbar new];
    [pickerToolbar sizeToFit];
    [pickerToolbar setItems:@[flexibleSpaceLeft, doneButton]];
    
    self.expirationDateTextField.inputView = pickerView;
    self.expirationDateTextField.inputAccessoryView = pickerToolbar;
}


#pragma mark -
#pragma mark Actions

- (void)pickerDoneButtonTapped
{
    [self.expirationDateTextField endEditing:YES];
}

- (IBAction)payButtonTapped:(id)sender
{
    STPCardParams *cardParams = [STPCardParams new];
    cardParams.number = self.cardNumberTextField.text;
    
    NSArray *expComp = [self.expirationDateTextField.text componentsSeparatedByString:@"/"];
    cardParams.expMonth = [[expComp firstObject] integerValue];
    cardParams.expYear = [[expComp lastObject] integerValue];
    cardParams.cvc = self.cvcNumberTextField.text;
    
    if ([STPCardValidator validationStateForCard:cardParams] == STPCardValidationStateValid) {
        [SVProgressHUD show];
        [[STPAPIClient sharedClient] createTokenWithCard:cardParams
                                              completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
                                                  if (error) {
                                                      [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                                  } else {
                                                      [SVProgressHUD showSuccessWithStatus:@"Token was received. You should send it to your server"];
                                                      [self performPayProcessForToken:token.tokenId];
                                                  }
                                              }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"Some values is invalid. Please check inputed values."];
    }
}


#pragma mark -
#pragma mark IMSExpDatePickerDataSourceDelegate

- (void)expDatePickerDataSource:(IMSExpDatePickerDataSource *)dataSource didSelectItem:(NSString *)item
{
    self.expirationDateTextField.text = item;
}


#pragma mark -
#pragma mark Help Methods

- (void)performPayProcessForToken:(NSString *)token
{
    NSUInteger amountInCents = [self.goat.price unsignedIntegerValue] * 100;
    NSDictionary *requestParams = @{@"stripeToken" : token,
                                    @"amount" : @(amountInCents)};
    
    //You should send request to server from here.
}


@end
