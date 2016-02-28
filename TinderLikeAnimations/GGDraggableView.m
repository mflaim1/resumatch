#import "GGDraggableView.h"
#import "GGOverlayView.h"

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
@end

@implementation GGDraggableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGestureRecognizer];

    [self loadImageAndStyle];

    self.overlayView = [[GGOverlayView alloc] initWithFrame:self.bounds];
    self.overlayView.alpha = 0;
    [self addSubview:self.overlayView];
    
    //create the dictionaries here
    NSMutableDictionary *tagDict= [[NSMutableDictionary alloc] init];
    NSMutableDictionary *photoDict= [[NSMutableDictionary alloc] init];
    
    //Arrays of Resumes based on tags
    NSArray *engineerArray = [NSArray arrayWithObjects:@"Charles_Evans.png", @"Grace_West.png",nil];
    NSArray *marketingArray = [NSArray arrayWithObjects:@"Aiden_Day.png", @"Monica_Watson.png",nil];
    NSArray *accountantArray = [NSArray arrayWithObjects:@"Jesse_Kendall.png", @"Bea_Counter.png",nil];
    NSArray *adminAssistantArray = [NSArray arrayWithObjects:@"Jane_Smith.png", @"Avery_Walker.png",nil];
    
    
    
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
    [photoDict setObject:[NSNumber numberWithBool:false]forKey:@"Aiden_Day.png"];
    [photoDict setObject:[NSNumber numberWithBool:false]forKey:@"Jesse_Kendall.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Bea_Counter.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Avery_Walker.png"];
    [photoDict setObject:[NSNumber numberWithBool:false] forKey:@"Jane_Smith.png"];
    [photoDict setObject:[NSNumber numberWithBool:true] forKey:@"Monica_Watson.png"];
    NSLog(@"%@", photoDict);


    return self;
}

- (void)loadImageAndStyle
{
    //create scrollview and add as subview and add this image as the scrollviews subview
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar"]];
    [self addSubview:imageView];
    self.layer.cornerRadius = 8;
    self.layer.shadowOffset = CGSizeMake(7, 7);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
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