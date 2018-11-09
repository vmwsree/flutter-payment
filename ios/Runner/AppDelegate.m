#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* paymentChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"payment_channel"
                                            binaryMessenger:controller];
    
    [paymentChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"openNativeWindow" isEqualToString:call.method]) {
             [self openRazorpayVC:controller result:result];
        } else {
            result(FlutterMethodNotImplemented);
        }
        // TODO
    }];
    
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
-(void)openRazorpayVC:(FlutterViewController*)controller result:(FlutterResult) result {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Payment" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"payment_firstview"];
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
    
}


@end
