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
    
    //_applicantButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _recruiterButton.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    _recruiterButton.layer.cornerRadius = 10;
    
    _recruiterButton.layer.masksToBounds = YES;
    _recruiterButton.layer.borderWidth = 0.5f;
    
    _recruiterButton.layer.shadowColor = [UIColor redColor].CGColor;
    _recruiterButton.layer.shadowOpacity = 20;
    _recruiterButton.layer.shadowRadius = 12;
    _recruiterButton.layer.shadowOffset = CGSizeMake(12.0f, 12.0f);
   
    
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
