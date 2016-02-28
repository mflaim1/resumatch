//
//  ApplicantController.m
//  Resumatch
//
//  Created by S Cohen on 2/28/16.
//  Copyright © 2016 theguti.self. All rights reserved.
//

#import "ApplicantController.h"

@interface ApplicantController ()

@end

@implementation ApplicantController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_uploadResumeButton setTitle:@"Upload Resume" forState:UIControlStateNormal];
    _uploadResumeButton.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    _uploadResumeButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _uploadResumeButton.layer.cornerRadius = 10;
    _uploadResumeButton.layer.masksToBounds = YES;
    _uploadResumeButton.layer.borderWidth = 3.0f;
    
    [_SubmitProfileButton setTitle:@"Submit" forState:UIControlStateNormal];
    _SubmitProfileButton.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    _SubmitProfileButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _SubmitProfileButton.layer.cornerRadius = 10;
    _SubmitProfileButton.layer.masksToBounds = YES;
    _SubmitProfileButton.layer.borderWidth = 3.0f;
    
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
- (IBAction)uploadResume:(id)sender {
    
}
- (IBAction)submitProfile:(id)sender {
}

@end
