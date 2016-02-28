//
// Created by guti on 1/17/14.
//
// No bugs for you!
//


#import <Foundation/Foundation.h>
#import "Likes.h"
@class GGOverlayView;


@interface GGDraggableView : UIView <UIScrollViewDelegate>

@property NSString *theTag;
@property (nonatomic,retain) Likes* likes;
-(void)loadTag;
@end