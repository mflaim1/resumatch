//
//  UISearchViewController.m
//  Resumatch
//
//  Created by S Cohen on 2/28/16.
//  Copyright © 2016 theguti.self. All rights reserved.
//

#import "UISearchViewController.h"

@interface UISearchViewController ()

@end

@implementation UISearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_searchButton setTitle:@"Search" forState:UIControlStateNormal];
    _searchButton.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    _searchButton.layer.backgroundColor = [UIColor whiteColor].CGColor;
    _searchButton.layer.cornerRadius = 10;
    _searchButton.layer.masksToBounds = YES;
    _searchButton.layer.borderWidth = 3.0f;
    
    
    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithTitle:@"Custom" style:UIBarButtonItemStylePlain target:self action:@selector(customBtnPressed)];
    [self.navigationItem setRightBarButtonItem:customBtn];
    
    [customBtn setImage:[UIImage imageNamed: @"profile1.png"]];
   // [customBtn setTintColor:(UIColor blackColor)];
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
- (IBAction)searchButton:(id)sender {
}

@end
