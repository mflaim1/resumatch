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
    _recruiterButton.layer.shadowOffset = CGSizeMake(0.0, -8.0);
    _recruiterButton.layer.backgroundColor = [UIColor lightGrayColor].CGColor;
    _recruiterButton.layer.shadowColor = [UIColor blackColor].CGColor;
    //_recruiterButton.layer.cornerRadius = [CGFloat(5.5, 8.1)];
   
    
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
