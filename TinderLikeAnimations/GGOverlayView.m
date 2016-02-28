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
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trollface_300x200"]];
    [self addSubview:self.imageView];

    return self;
}

- (void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) return;

    _mode = mode;
    if (mode == GGOverlayViewModeLeft) {
        self.imageView.image = [UIImage imageNamed:@"trollface_300x200"];
         self.imageView.frame = CGRectMake(80, 80, 100, 100);
    } else {
        self.imageView.image = [UIImage imageNamed:@"thumbs_up_300x300"];
         self.imageView.frame = CGRectMake(50, 50, 100, 100);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
   
}

@end