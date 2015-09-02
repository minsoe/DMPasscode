//
//  DMPasscodeTimeoutNavigationController.m
//  Pods
//
//  Created by Min Soe Zan on 2/9/15.
//
//

#import "DMPasscodeTimeoutController.h"

@interface DMPasscodeTimeoutController () <UITextFieldDelegate>

@property(nonatomic, strong) NSTimer *timer;

@end

@implementation DMPasscodeTimeoutController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self resetTimer];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self resetTimer];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  [self resetTimer];
}

- (void)resetTimer {
  [self.timer invalidate];
  self.timer = nil;
  self.timer = [NSTimer timerWithTimeInterval:3
                                       target:self
                                     selector:@selector(dismiss)
                                     userInfo:nil
                                      repeats:NO];
  [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)dismiss {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)editingChanged:(UITextField *)sender {
  [super editingChanged:sender];
  [self resetTimer];
}

@end
