//
//  IMSSTPPaymentCardTextFieldViewController.m
//  CrazyGoats
//
//  Created by Max on 07.04.16.
//  Copyright © 2016 InMotionSoft. All rights reserved.
//

#import "IMSSTPPaymentCardTextFieldViewController.h"

@import Stripe;
@import SVProgressHUD;


@interface IMSSTPPaymentCardTextFieldViewController () <STPPaymentCardTextFieldDelegate>

@property (weak, nonatomic) IBOutlet STPPaymentCardTextField *paymentCardTextField;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@end

@implementation IMSSTPPaymentCardTextFieldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark -
#pragma mark Actions

- (IBAction)payButtonTapped:(id)sender
{
    [SVProgressHUD show];
    [[STPAPIClient sharedClient] createTokenWithCard:self.paymentCardTextField.cardParams
                                          completion:^(STPToken * _Nullable token, NSError * _Nullable error) {
                                              if (error) {
                                                  [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                              } else {
                                                  [SVProgressHUD showSuccessWithStatus:@"Token was received. You should send it to your server"];
                                                  [self performPayProcessForToken:token.tokenId];
                                              }
                                          }];
}


#pragma mark -
#pragma mark STPPaymentCardTextFieldDelegate

- (void)paymentCardTextFieldDidChange:(STPPaymentCardTextField *)textField
{
    self.payButton.enabled = textField.isValid;
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
