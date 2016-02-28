//
//  UISearchViewController.h
//  Resumatch
//
//  Created by S Cohen on 2/28/16.
//  Copyright © 2016 theguti.self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileLogo;
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end
