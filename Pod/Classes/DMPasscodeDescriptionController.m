//
//  DMPasscodeTimeoutNavigationController.m
//  Pods
//
//  Created by Min Soe Zan on 2/9/15.
//
//

#import "DMPasscodeDescriptionController.h"

@interface DMPasscodeDescriptionController ()

@property(nonatomic, strong) UILabel *descriptionLabel;

@property(nonatomic, strong) NSAttributedString *descriptionText;
@property(nonatomic, strong) DMPasscodeConfig *descriptionConfig;

@end

@implementation DMPasscodeDescriptionController

- (id)initWithDelegate:(id<DMPasscodeInternalViewControllerDelegate>)delegate
                config:(DMPasscodeConfig *)config
           description:(NSAttributedString *)description {
  self = [super initWithDelegate:delegate config:config];
  if (self) {
    self.descriptionConfig = config;
    self.descriptionText = description;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.descriptionLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(50, 250, self.view.frame.size.width - 100,
                               self.view.frame.size.height - 250)];

  //  self.descriptionLabel.backgroundColor = [UIColor redColor];
  //  self.descriptionLabel.font = self.descriptionConfig.descriptionFont;
  //  self.descriptionLabel.textColor = _descriptionConfig.descriptionTextColor;
  self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
  self.descriptionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  self.descriptionLabel.attributedText = self.descriptionText;
  //  self.descriptionLabel.numberOfLines = 0;
  [self.view addSubview:self.descriptionLabel];
  //  [self.descriptionLabel sizeToFit];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
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

@end
