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
    self.layer.cornerRadius=10;
    return self;
}

- (void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) return;

    _mode = mode;
    if (mode == GGOverlayViewModeLeft) {
        //self.imageView.image = [UIImage imageNamed:@"trollface_300x200"];
         self.backgroundColor=[UIColor redColor];
        
    } else {
             self.backgroundColor=[UIColor greenColor];
       
       // self.imageView.image = [UIImage imageNamed:@"thumbs_up_300x300"];
         //self.frame = CGRectMake(0, 0, 50, 50);
    }
     //self.frame = CGRectMake(self.center.x, self.center.y,300, 500);
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
}

@end