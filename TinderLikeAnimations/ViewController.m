//
//  ViewController.m
//  TinderLikeAnimations
//
//  Created by Nimrod Gutman on 1/17/14.
//  Copyright (c) 2014 theguti.self. All rights reserved.
//

#import "ViewController.h"
#import "GGView.h"
#import "LikesTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
   GGView *theView=[[GGView alloc] init];
    theView.theTag=self.theTag;
    [theView loadDraggableCustomView ];
    self.view =theView;
    
    self.view.backgroundColor=[UIColor blackColor];
    
    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithTitle:@"Likes" style:UIBarButtonItemStylePlain target:self action:@selector(customBtnPressed)];
    [self.navigationItem setRightBarButtonItem:customBtn];
}

-(void)customBtnPressed{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LikesTableViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"LikesTableViewController"];
    //[self.playerControls closePlayer:YES animated:YES];
    //self.playerControls.locked = YES;
    
    [self presentViewController:vc animated:YES completion:nil];
    

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"seeLikes"])
    {
       // NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       // NSDate *object = _objects[indexPath.row];
        //[[segue destinationViewController] setDetailItem:object];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
