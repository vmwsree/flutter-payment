//
//  ViewController.m
//  Runner
//
//  Created by Rushil Malhotra on 25/10/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ViewController.h"
#import <Razorpay/Razorpay.h>

static NSString *const SUCCESS_TITLE = @"Success!";
static NSString *const SUCCESS_MESSAGE =
@"Your payment was successful. The payment ID is %@";
static NSString *const FAILURE_TITLE = @"Uh-Oh!";
static NSString *const FAILURE_MESSAGE =
@"Your payment failed due to an error.\nCode: %d\nDescription: %@";
static NSString *const EXTERNAL_METHOD_TITLE = @"Umm?";
static NSString *const EXTERNAL_METHOD_MESSAGE =
@"You selected %@, which is not supported by Razorpay at the moment.\nDo "
@"you want to handle it separately?";
static NSString *const OK_BUTTON_TITLE = @"OK";
@interface ViewController () <RazorpayPaymentCompletionProtocol,
ExternalWalletSelectionProtocol> {
    Razorpay *razorpay;
}

@end

@implementation ViewController
- (IBAction)goback:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    razorpay = [Razorpay initWithKey:@"rzp_test_1DP5mmOlF5G5ag" andDelegate:self];
    [razorpay setExternalWalletSelectionDelegate:self];
    // Do any additional setup after loading the view.
}
- (IBAction)openPay:(id)sender {
    NSDictionary *options = @{
                              @"amount" : @"50000",
                              @"currency" : @"INR",
                              @"description" : @"Flutter T-shirt",
                              @"name" : @"Razorpay",
                              @"external" : @{@"wallets" : @[ @"paytm" ]},
                              @"prefill" :
                                  @{@"email" : @"vivek@razorpay.com", @"contact" : @"9711631851"},
                              @"theme" : @{@"color" : @"#3594E2"}
                              };
    
    [razorpay open:options];
}

- (void)onPaymentSuccess:(NSString *)payment_id {
    [self showAlertWithTitle:SUCCESS_TITLE
                  andMessage:[NSString
                              stringWithFormat:SUCCESS_MESSAGE, payment_id]];
}

- (void)onPaymentError:(int)code description:(NSString *)str {
    [self showAlertWithTitle:FAILURE_TITLE
                  andMessage:[NSString
                              stringWithFormat:FAILURE_MESSAGE, code, str]];
}

- (void)onExternalWalletSelected:(NSString *)walletName
                 WithPaymentData:(NSDictionary *)paymentData {
    [self showAlertWithTitle:EXTERNAL_METHOD_TITLE
                  andMessage:[NSString stringWithFormat:EXTERNAL_METHOD_MESSAGE,
                              walletName]];
}

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    if ([[[UIDevice currentDevice] systemVersion]
         compare:@"8.0"
         options:NSNumericSearch] != NSOrderedAscending) {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:title
                                    message:message
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction =
        [UIAlertAction actionWithTitle:OK_BUTTON_TITLE
                                 style:UIAlertActionStyleCancel
                               handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:OK_BUTTON_TITLE
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
