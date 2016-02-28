#import "GGView.h"
#import "GGDraggableView.h"


@interface GGView ()

@end

@implementation GGView

- (id)init
{
    self = [super init];
    if (!self) return nil;

    self.backgroundColor = [UIColor whiteColor];

    //[self loadDraggableCustomView];

    return self;
}

- (void)loadDraggableCustomView
{
    //change size here
   
    self.draggableView = [[GGDraggableView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
     self.draggableView.theTag=self.theTag;
    [self.draggableView loadTag];
    NSLog(@"HIIII %@",self.draggableView.theTag);
    [self addSubview:self.draggableView];
}

@end