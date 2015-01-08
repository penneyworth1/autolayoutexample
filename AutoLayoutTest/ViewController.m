//
//  ViewController.m
//  AutoLayoutTest
//
//  Created by Steven Stewart on 1/8/15.
//  Copyright (c) 2015 Steven Stewart. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGFloat viewWidth;
    CGFloat viewHeight;
}

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIButton *dismissButton;
@property (nonatomic, strong) NSLayoutConstraint *headerViewHeight;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) NSLayoutConstraint *footerHeightConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewWidth = [[UIScreen mainScreen] bounds].size.width;
    viewHeight = [[UIScreen mainScreen] bounds].size.height;
    //shouldAdjustMenuBars = YES;
    //[self setupData];
    [self setupViews];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    headerView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:headerView];
    [self.view bringSubviewToFront:headerView];
    self.headerView = headerView;
    
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dismissButton.TranslatesAutoresizingMaskIntoConstraints = NO;
    [self.dismissButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [self.dismissButton setContentMode:UIViewContentModeCenter];
    [self.headerView addSubview:self.dismissButton];
    
    self.headerLabel = [[UILabel alloc] init];
    self.headerLabel.TranslatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.text = @"ADD TO FLOW";
    [self.headerView addSubview:self.headerLabel];
    self.headerLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:20];
    self.headerLabel.textColor = [UIColor whiteColor];
    
    
    self.doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.doneButton.backgroundColor = [UIColor blueColor];
    self.doneButton.TranslatesAutoresizingMaskIntoConstraints = NO;
    [self.doneButton setTitle:@"DONE" forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor colorWithRed:1.0000 green:0.4745 blue:0.2784 alpha:1.0f] forState:UIControlStateNormal];
    [self.doneButton setContentMode:UIViewContentModeCenter];
    [self.headerView addSubview:self.doneButton];
    
    self.middleView = [[UIView alloc] init];
    self.middleView.translatesAutoresizingMaskIntoConstraints = NO;
    self.middleView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.middleView];
    
    UIView *middleInside = [[UIView alloc] init];
    middleInside.translatesAutoresizingMaskIntoConstraints = NO;
    middleInside.backgroundColor = [UIColor whiteColor];
    [self.middleView addSubview:middleInside];
    
    
    [self.middleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[middleInside]-20-|" options:0 metrics:nil views:@{@"middleInside": middleInside}]];
    [self.middleView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[middleInside]-20-|" options:0 metrics:nil views:@{@"middleInside": middleInside}]];
    
    self.footerView = [[UIView alloc] init];
    self.footerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.footerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.footerView];
    
    
    NSDictionary *bindings = NSDictionaryOfVariableBindings(headerView, _dismissButton, _headerLabel, _doneButton, _footerView, _middleView);
    
    [self.headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_dismissButton(40)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_dismissButton)]];
    [self.headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_dismissButton(42)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_dismissButton)]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.headerLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_headerLabel(42)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_headerLabel)]];
    [self.headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_doneButton(60)]-10-|" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_doneButton)]];
    [self.headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_doneButton(40)]" options:0 metrics:0 views:NSDictionaryOfVariableBindings(_doneButton)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView(80)][_middleView][_footerView]|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_middleView]|" options:0 metrics:nil views:bindings]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_footerView(50)]-10-|" options:0 metrics:nil views:bindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_footerView]|" options:0 metrics:nil views:bindings]];
    
    self.footerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.footerView
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeHeight
                                                              multiplier:0.2f
                                                                constant:10.f];
    [self.view addConstraint:self.footerHeightConstraint];
    
    [self.view layoutIfNeeded];
    
    //do layer stuff
    
    //animations
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.footerHeightConstraint.constant = 60.f;
        [UIView animateWithDuration:0.5f
                              delay:0.f
             usingSpringWithDamping:0.6f
              initialSpringVelocity:0.7f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.view layoutIfNeeded];
                         } completion:^(BOOL finished) {
                             self.footerHeightConstraint.constant = 0.f;
                             [UIView animateWithDuration:0.5f
                                                   delay:0.3f
                                  usingSpringWithDamping:0.6f
                                   initialSpringVelocity:0.7f
                                                 options:UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  [self.view layoutIfNeeded];
                                              } completion:^(BOOL finished) {
                                                  
                                              }];
                         }];
    });
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
