//
//  LaunchViewController.m
//  Resumatch
//
//  Created by S Cohen on 2/27/16.
//  Copyright © 2016 theguti.self. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [_applicantButton setTitle:@"Applicant" forState:UIControlStateNormal];
    _applicantButton.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    _applicantButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _applicantButton.layer.cornerRadius = 10;
    _applicantButton.layer.masksToBounds = YES;
    _applicantButton.layer.borderWidth = 3.0f;
    
  
    
    [_recruiterButton setTitle:@"Recruiter" forState:UIControlStateNormal];
    _recruiterButton.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    _recruiterButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _recruiterButton.layer.cornerRadius = 10;
    _recruiterButton.layer.masksToBounds = YES;
    _recruiterButton.layer.borderWidth = 3.0f;
    
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
- (IBAction)ApplicantButton:(id)sender {
    

    
}

- (IBAction)RecruiterButton:(id)sender {
    

}
@end
