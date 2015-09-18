//
//  DMAppDelegate.m
//  DMPasscode
//
//  Created by CocoaPods on 09/20/2014.
//  Copyright (c) 2014 Dylan Marriott. All rights reserved.
//

#import "DMAppDelegate.h"
#import <DMPasscode/DMPasscode.h>

@implementation DMAppDelegate {
  UIViewController *_rootViewController;
  UIButton *_setupButton;
  UIButton *_checkButton;
  UIButton *_removeButton;
  BOOL _showingPasscode;
}

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  _rootViewController = [[UIViewController alloc] init];
  self.window.rootViewController = _rootViewController;
  [self addViews];
  [self updateViews];

  /*
  // Example for a different config.

  DMPasscodeConfig* config = [[DMPasscodeConfig alloc] init];
  config.navigationBarBackgroundColor = [UIColor colorWithRed:0.10 green:0.34
  blue:0.61 alpha:1.00];
  config.navigationBarForegroundColor = [UIColor whiteColor];
  config.fieldColor = [UIColor colorWithRed:0.10 green:0.34 blue:0.61
  alpha:1.00];
  config.emptyFieldColor = [UIColor colorWithRed:0.10 green:0.34 blue:0.61
  alpha:1.00];
  config.statusBarStyle = UIStatusBarStyleLightContent;
  [DMPasscode setConfig:config];
  */

  return YES;
}

- (void)addViews {
  _setupButton = [[UIButton alloc]
      initWithFrame:CGRectMake(0, 50, _rootViewController.view.frame.size.width,
                               50)];
  [_setupButton setTitle:@"Setup" forState:UIControlStateNormal];
  [_setupButton setTitleColor:[UIColor blackColor]
                     forState:UIControlStateNormal];
  [_setupButton addTarget:self
                   action:@selector(actionSetup:)
         forControlEvents:UIControlEventTouchUpInside];
  [_rootViewController.view addSubview:_setupButton];

  _checkButton = [[UIButton alloc]
      initWithFrame:CGRectMake(0, 100,
                               _rootViewController.view.frame.size.width, 50)];
  [_checkButton setTitle:@"Check" forState:UIControlStateNormal];
  [_checkButton setTitleColor:[UIColor blackColor]
                     forState:UIControlStateNormal];
  [_checkButton setTitleColor:[UIColor lightGrayColor]
                     forState:UIControlStateDisabled];
  [_checkButton addTarget:self
                   action:@selector(actionCheck:)
         forControlEvents:UIControlEventTouchUpInside];
  [_rootViewController.view addSubview:_checkButton];

  _removeButton = [[UIButton alloc]
      initWithFrame:CGRectMake(0, 150,
                               _rootViewController.view.frame.size.width, 50)];
  [_removeButton setTitle:@"Remove" forState:UIControlStateNormal];
  [_removeButton setTitleColor:[UIColor blackColor]
                      forState:UIControlStateNormal];
  [_removeButton setTitleColor:[UIColor lightGrayColor]
                      forState:UIControlStateDisabled];
  [_removeButton addTarget:self
                    action:@selector(actionRemove:)
          forControlEvents:UIControlEventTouchUpInside];
  [_rootViewController.view addSubview:_removeButton];
}

- (void)actionSetup:(UIButton *)sender {
  //  DMPasscodeConfig *config = [[DMPasscodeConfigAddition alloc] init];

  //  [DMPasscode setConfig:config];

  //  [DMPasscode setupPasscodeInViewController:_rootViewController
  //                                 completion:^(BOOL success, NSError *error)
  //                                 {
  //                                   [self updateViews];
  //                                 }];
  NSString *line1 = @"This code is needed to access the iDisplay settings";
  NSString *line2 = @"<br />Note: Please choose a code that is not easy to "
      @"guess (e.g. 1234).";
  NSString *line3 = @"<br />This way you ensure that only authorized users can "
      @"access the settings.";
  NSParagraphStyle *paragraphStyle = [NSParagraphStyle defaultParagraphStyle];

  NSDictionary *options = @{
    NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
    NSParagraphStyleAttributeName : paragraphStyle
  };

  //  NSMutableAttributedString *description =
  //      [[NSMutableAttributedString alloc] initWithString:test
  //                                             attributes:options];
  NSError *error;
  NSAttributedString *description = [[NSAttributedString alloc]
            initWithData:[[[line1 stringByAppendingString:line2]
                             stringByAppendingString:line3]
                             dataUsingEncoding:NSUTF8StringEncoding]
                 options:options
      documentAttributes:nil
                   error:&error];

  [DMPasscode setupPasscodeInViewController:_rootViewController
                                description:description
                                 completion:^(BOOL success, NSError *error) {
                                   [self updateViews];
                                 }];
}

- (void)actionCheck:(UIButton *)sender {
  [DMPasscode
      showPasscodeInViewController:_rootViewController
                        completion:^(BOOL success, NSError *error) {
                          if (success) {
                            [sender setTitleColor:[UIColor greenColor]
                                         forState:UIControlStateNormal];
                          } else {
                            if (error) {
                              // Failed authentication
                              [sender setTitleColor:[UIColor redColor]
                                           forState:UIControlStateNormal];
                            } else {
                              // Cancelled
                              [sender setTitleColor:[UIColor blackColor]
                                           forState:UIControlStateNormal];
                            }
                          }
                          [self updateViews];
                        }];
}

- (void)actionRemove:(id)sender {
  [DMPasscode removePasscode];
  [_checkButton setTitleColor:[UIColor blackColor]
                     forState:UIControlStateNormal];
  [self updateViews];
}

- (void)updateViews {
  BOOL passcodeSet = [DMPasscode isPasscodeSet];
  _checkButton.enabled = passcodeSet;
  _removeButton.enabled = passcodeSet;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  if ([DMPasscode isPasscodeSet] && !_showingPasscode) {
    _showingPasscode = YES;
    [DMPasscode showPasscodeInViewController:self.window.rootViewController
                                  completion:^(BOOL success, NSError *error) {
                                    if (success) {
                                      NSLog(@"Win");
                                    } else {

                                      NSLog(@"Loss");
                                    }
                                  }];
  }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  _showingPasscode = NO;
}

@end
