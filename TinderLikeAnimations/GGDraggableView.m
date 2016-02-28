#import "GGDraggableView.h"
#import "GGOverlayView.h"
#define ZOOM_STEP 2.0
@interface GGDraggableView ()
@property(nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic) CGPoint originalPoint;
@property(nonatomic, strong) GGOverlayView *overlayView;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIScrollView *scrollview;
@end

@implementation GGDraggableView
@synthesize scrollview,imageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGestureRecognizer];

    [self loadImageAndStyle];

       return self;
}

- (void)loadImageAndStyle
{
    //create scrollview and add as subview and add this image as the scrollviews subview
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
   
    scrollview.contentSize = CGSizeMake(300, 500);
    scrollview.delegate=self;
    [self addSubview:scrollview];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    imageView.image=[UIImage imageNamed:@"resume"];
    [scrollview addSubview:imageView];
    self.overlayView = [[GGOverlayView alloc] initWithFrame:self.bounds];
    self.overlayView.alpha = 0;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    [doubleTap setNumberOfTapsRequired:2];
    [twoFingerTap setNumberOfTouchesRequired:2];
    
    //Adding gesture recognizer
    [imageView addGestureRecognizer:doubleTap];
    [imageView addGestureRecognizer:twoFingerTap];
    

    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = 1.0;//This is the minimum scale, set it to whatever you want. 1.0 = default
    scrollview.maximumZoomScale = 4.0;
    scrollview.minimumZoomScale = minimumScale;
    scrollview.zoomScale = minimumScale;
    [scrollview setContentMode:UIViewContentModeScaleAspectFit];
    //[imageView sizeToFit];
    [scrollview setContentSize:CGSizeMake(imageView.frame.size.width, imageView.frame.size.height)];

    [imageView addSubview:self.overlayView];
}

- (void)dragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat xDistance = [gestureRecognizer translationInView:self].x;
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
            //load another picture here
            [self resetViewPositionAndTransformations];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    CGFloat offsetX = (scrollview.bounds.size.width > scrollview.contentSize.width)?
    (scrollview.bounds.size.width - scrollview.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollview.bounds.size.height > scrollview.contentSize.height)?
    (scrollview.bounds.size.height - scrollview.contentSize.height) * 0.5 : 0.0;
    imageView.center = CGPointMake(scrollview.contentSize.width * 0.5 + offsetX,
                                   scrollview.contentSize.height * 0.5 + offsetY);
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

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // zoom in
    float newScale = [scrollview zoomScale] * ZOOM_STEP;
    
    if (newScale > self.scrollview.maximumZoomScale){
        newScale = self.scrollview.minimumZoomScale;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        
        [scrollview zoomToRect:zoomRect animated:YES];
        
    }
    else{
        
        newScale = self.scrollview.maximumZoomScale;
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        
        [scrollview zoomToRect:zoomRect animated:YES];
    }
}


- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    float newScale = [scrollview zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [scrollview zoomToRect:zoomRect animated:YES];
}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
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
}


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

- (void)resetViewPositionAndTransformations
{
    [UIView animateWithDuration:0.2
                     animations:^{
        self.center = self.originalPoint;
        self.transform = CGAffineTransformMakeRotation(0);
        self.overlayView.alpha = 0;
    }];
}

- (void)dealloc
{
    [self removeGestureRecognizer:self.panGestureRecognizer];
}

@end