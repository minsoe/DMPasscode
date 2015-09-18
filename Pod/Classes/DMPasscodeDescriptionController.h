//
//  DMPasscodeTimeoutNavigationController.h
//  Pods
//
//  Created by Min Soe Zan on 2/9/15.
//
//

#import "DMPasscodeInternalViewController.h"
#import "DMPasscodeConfig.h"

@interface DMPasscodeDescriptionController : DMPasscodeInternalViewController

- (id)initWithDelegate:(id<DMPasscodeInternalViewControllerDelegate>)delegate
                config:(DMPasscodeConfig *)config
           description:(NSAttributedString *)description;

@end
