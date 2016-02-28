#import "GGOverlayView.h"

@interface GGOverlayView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation GGOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;

    self.backgroundColor = [UIColor whiteColor];
    //self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trollface_300x200"]];
    [self addSubview:self.imageView];

    return self;
}

- (void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) return;

    _mode = mode;
    if (mode == GGOverlayViewModeLeft) {
        //self.imageView.image = [UIImage imageNamed:@"trollface_300x200"];
       self.backgroundColor=[UIColor greenColor];
         //self.frame = CGRectMake(0, 0, 50, 50);
    } else {
        
         self.backgroundColor=[UIColor redColor];
       // self.imageView.image = [UIImage imageNamed:@"thumbs_up_300x300"];
         //self.frame = CGRectMake(0, 0, 50, 50);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
}

@end