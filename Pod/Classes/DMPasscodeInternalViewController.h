//
//  DMPasscodeInternalViewController.h
//  Pods
//
//  Created by Dylan Marriott on 20/09/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DMPasscodeInternalViewControllerDelegate <NSObject>

- (void)enteredCode:(NSString *)code;
- (void)canceled;

@end

@class DMPasscodeConfig;

@interface DMPasscodeInternalViewController
    : UIViewController <UITextFieldDelegate>

- (id)initWithDelegate:(id<DMPasscodeInternalViewControllerDelegate>)delegate
                config:(DMPasscodeConfig *)config;
- (void)reset;
- (void)setErrorMessage:(NSString *)errorMessage;
- (void)setInstructions:(NSString *)instructions;

- (void)editingChanged:(UITextField *)sender;
@end
