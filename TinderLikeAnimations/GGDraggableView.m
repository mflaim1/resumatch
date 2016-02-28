#import "GGDraggableView.h"
#import "GGOverlayView.h"
#define ZOOM_STEP 2.0
@interface GGDraggableView ()
@property(nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic) CGPoint originalPoint;
@property(nonatomic, strong) GGOverlayView *overlayView;
@property (strong, nonatomic) NSMutableDictionary *tagDict ;
//photoDict has the photoName as the key and whether is was liked or not as the value
@property (strong, nonatomic) NSMutableDictionary *photoDict ;
@property (strong, nonatomic) NSMutableArray *engineerArray;
@property (strong, nonatomic) NSMutableArray *marketingArray;
@property (strong, nonatomic) NSMutableArray *accountantArray;
@property (strong, nonatomic) NSMutableArray *adminAssistantArray;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIScrollView *scrollview;
@property int index;
@property NSString *tag;
@property NSMutableArray *currArray;

@end

@implementation GGDraggableView
@synthesize scrollview,imageView, engineerArray, marketingArray, accountantArray, adminAssistantArray, index, tag, tagDict, photoDict, currArray;
- (id)initWithFrame:(CGRect)frame
{
    //hard coded this tag for now - eventually this will read in from the search field
    tag = @"Marketing";
    index=0;
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGestureRecognizer];

    

    self.overlayView = [[GGOverlayView alloc] initWithFrame:CGRectMake(20, 150, 300, 500)];
    self.overlayView.alpha = 0;
    [self addSubview:self.overlayView];
    
    //create the dictionaries here
    tagDict= [[NSMutableDictionary alloc] init];
    photoDict= [[NSMutableDictionary alloc] init];
    
 
    
    //Arrays of Resumes based on tags
    engineerArray = [NSMutableArray arrayWithObjects:@"Charles_Evans.png", @"Grace_West.png",nil];
    marketingArray = [NSMutableArray arrayWithObjects: @"Monica_Watson.png", @"Karen_Meyer.png", @"Ethan_Burton.png", @"Valerie_Wilmer.png",nil];
    accountantArray = [NSMutableArray arrayWithObjects:@"Jesse_Kendall.png", @"Bea_Counter.png",nil];
    adminAssistantArray = [NSMutableArray arrayWithObjects:@"Jane_Smith.png", @"Avery_Walker.png",nil];
    
    
    
    //tagDict keys are the tags and the values is a list of images that meet that tag
    [tagDict setObject:engineerArray forKey:@"Software Engineer"];
    [tagDict setObject:marketingArray  forKey:@"Marketing"];
    [tagDict setObject:accountantArray forKey:@"Accountant"];
    [tagDict setObject:adminAssistantArray forKey:@"Admin Assistant"];
    NSLog(@"%@", tagDict);
    
    //photoDict has the key as the photoName and they key as a bool if it is liked
    //default for images is false - they are not liked, then update the value when it is swiped
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Charles_Evans.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Grace_West.png"];
    [photoDict setObject:[NSNumber numberWithBool:false]forKey:@"Jesse_Kendall.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Bea_Counter.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Avery_Walker.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Jane_Smith.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Monica_Watson.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Karen_Meyer.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Ethan_Burton.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Valerie_Wilmer.png"];
    NSLog(@"%@", photoDict);

    currArray =[tagDict objectForKey:tag];

    [self loadImageAndStyle];
    return self;
}


- (void)loadImageAndStyle
{
    //create scrollview and add as subview and add this image as the scrollviews subview
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 150, 300, 500)];
   
    //scrollview.contentSize = CGSizeMake(300, 300);
    scrollview.delegate=self;
    [self addSubview:scrollview];
    scrollview.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 150, 300, 500)];
    
    imageView.image=[UIImage imageNamed:currArray[index]];
        

    [scrollview addSubview:imageView];
    self.overlayView = [[GGOverlayView alloc] initWithFrame:self.bounds];
    self.overlayView.alpha = 0;
  
    
    //Adding gesture recognizer
    

    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = 1.0;//This is the minimum scale, set it to whatever you want. 1.0 = default
    scrollview.maximumZoomScale = 4.0;
    scrollview.minimumZoomScale = minimumScale;
    scrollview.zoomScale = minimumScale;
    [scrollview setContentMode:UIViewContentModeScaleAspectFit];
    //[imageView sizeToFit];


    [imageView addSubview:self.overlayView];
}

- (void)dragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat xDistance = [gestureRecognizer translationInView:self].x;
    NSLog(@"x distance: %f",xDistance);
    CGFloat yDistance = [gestureRecognizer translationInView:self].y;

    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
        case UIGestureRecognizerStateChanged:{
            CGFloat rotationStrength = MIN(xDistance / 320, 1);
            CGFloat rotationAngel = (CGFloat) (2*M_PI/16 * rotationStrength);
            CGFloat scaleStrength = 1 - fabsf(rotationStrength) / 4;
            CGFloat scale = MAX(scaleStrength, 0.93);
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            self.transform = scaleTransform;
            self.center = CGPointMake(self.originalPoint.x + xDistance, self.originalPoint.y + yDistance);

            [self updateOverlay:xDistance];

            break;
        };
        case UIGestureRecognizerStateEnded: {
            if(xDistance >=140||xDistance<=-150){
                NSLog(@"Bool before: %@", [photoDict objectForKey:currArray[index]]);
                if( self.overlayView.mode == 1){
                    [photoDict setObject:[NSNumber numberWithBool:true] forKey:currArray[index]];
                }
                
                [self resetViewPositionAndTransformations];
                
                //need to index through the resumes here
                index++;
                if(index >= marketingArray.count){
                    index = 0;
                }
                NSLog(@" Array %@",marketingArray[index]);
                imageView.image = [UIImage imageNamed:marketingArray[index]];

            }else{
                [self goBack];
            }
            //load another picture here
            //make an index variable and have it load the next index when the previous image is swiped

          
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}


- (void)viewDidUnload {
    self.scrollview = nil;
    self.imageView = nil;
}



#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
       return imageView;
}

#pragma mark TapDetectingImageViewDelegate methods


#pragma mark Utility methods

/*- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [scrollview frame].size.height / scale;
    zoomRect.size.width  = [scrollview frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}*/


- (void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        self.overlayView.mode = GGOverlayViewModeRight;
    } else if (distance <= 0) {
        self.overlayView.mode = GGOverlayViewModeLeft;
    }
    CGFloat overlayStrength = MIN(fabsf(distance) / 100, 0.4);
    self.overlayView.alpha = overlayStrength;
}
-(void)goBack{
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.center = self.originalPoint;
                         self.transform = CGAffineTransformMakeRotation(0);
                         self.overlayView.alpha = 0;
                     }];
}
- (void)resetViewPositionAndTransformations
{
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
     self.center = self.originalPoint;
    self.overlayView.alpha = 0;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // animate it to the identity transform (100% scale)
        self.transform = CGAffineTransformIdentity;
          self.center = self.originalPoint;
          self.overlayView.alpha = 0;
    } completion:^(BOOL finished){
        // if you want to do something once the animation finishes, put it here
    }];
    

}

- (void)dealloc
{
    [self removeGestureRecognizer:self.panGestureRecognizer];
}

@end