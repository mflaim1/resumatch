//
//  UISearchViewController.m
//  Resumatch
//
//  Created by S Cohen on 2/28/16.
//  Copyright © 2016 theguti.self. All rights reserved.
//

#import "UISearchViewController.h"
#import "ViewController.h"
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
    
    
    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStylePlain target:self action:@selector(customBtnPressed)];
    [self.navigationItem setRightBarButtonItem:customBtn];
    
   // [customBtn setImage:[UIImage imageNamed: @"profile1.png"]];
   // [customBtn setTintColor:(UIColor blackColor)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [self.searchField resignFirstResponder];
}
-(void)customBtnPressed{
    
}
#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     if ([[segue identifier] isEqualToString:@"search"]) {
         
         // Get destination view
         ViewController *vc = [segue destinationViewController];
         
         // Get button tag number (or do whatever you need to do here, based on your object
         NSInteger tagIndex = [(UIButton *)sender tag];
         
         // Pass the information to your destination view
         [vc setTheTag:self.searchField.text];
     }
}
- (IBAction)searchButton:(id)sender {
    
}

@end
