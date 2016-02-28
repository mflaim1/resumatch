//
// Created by guti on 1/17/14.
//
// No bugs for you!
//


#import <Foundation/Foundation.h>

@class GGDraggableView;


@interface GGView : UIView
@property(nonatomic, strong) GGDraggableView *draggableView;
@property NSString *theTag;
- (void)loadDraggableCustomView;
@end
