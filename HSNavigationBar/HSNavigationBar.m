#import "HSNavigationBar.h"
#import "Masonry.h"

#define bgColor_default [UIColor whiteColor]

#define separatorColor_default [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]

#define title_font_default [UIFont boldSystemFontOfSize:17]

#define title_color_default [UIColor blackColor]

@interface HSNavigationBar ()

@property (nonatomic,strong) UIImageView *separatorLine; // 分隔线
@property (nonatomic,strong) UIImageView *background; // 背景

@end

@implementation HSNavigationBar

#pragma mark - initial
- (id)init {
    if (self = [super init]) {
        self.backgroundColor = bgColor_default;
        _separatorColor = separatorColor_default;
        [self setup];
    }
    
    return self;
}

#pragma mark - load
- (void)setup {
    // separatorLine
    _separatorLine = [[UIImageView alloc] init];
    _separatorLine.backgroundColor = _separatorColor;
    [self addSubview:_separatorLine];
    [_separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    // background
    _background = [[UIImageView alloc] init];
    _background.backgroundColor = [UIColor clearColor];
    [self addSubview:_background];
    [_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - custom setter
- (void)setTitle:(NSString *)title {
    _title = title;
    if (_middleView) {
        [_middleView removeFromSuperview];
        _middleView = nil;
    }
    // 要设置标题属性直接在下面代码中设置
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = title_font_default;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = title_color_default;
    titleLabel.text = _title;
    [self addSubview:titleLabel];
    _middleView = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0.0, 41.0, 0.0, 41.0));
    }];
}

- (void)setRightActionTitle:(NSString *)rightActionTitle {
    _rightActionTitle = rightActionTitle;
    if (_rightView) {
        [_rightView removeFromSuperview];
        _rightView = nil;
    }
    CGSize textSize = [self calculateSize:rightActionTitle];
    
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarBtn addTarget:self action:@selector(rightBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    rightBarBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBarBtn setTitle:rightActionTitle forState:UIControlStateNormal];
    [rightBarBtn setTitle:rightActionTitle forState:UIControlStateHighlighted];
    [rightBarBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [rightBarBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:255/255.0 alpha:0.7] forState:UIControlStateHighlighted];
    [self addSubview:rightBarBtn];
    _rightView = rightBarBtn;
    [rightBarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        // 文字距左右边距为17
        make.width.mas_equalTo(textSize.width + 34);
    }];
}

- (void)setRightActionIcons:(NSArray *)rightActionIcons {
    _rightActionIcons = rightActionIcons;
    if (_rightView) {
        [_rightView removeFromSuperview];
        _rightView = nil;
    }
    if (!rightActionIcons.count) {
        return;
    }
    
    UIImage *normalImage = [_rightActionIcons firstObject];
    UIImage *highlightedImage = _leftActionIcons.count > 1? [_rightActionIcons lastObject] : nil;
    CGSize iconSize = normalImage.size.width >= highlightedImage.size.width ? normalImage.size : highlightedImage.size;
    
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarBtn.backgroundColor = [UIColor clearColor];
    [rightBarBtn addTarget:self action:@selector(rightBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBarBtn setImage:normalImage forState:UIControlStateNormal];
    [rightBarBtn setImage:highlightedImage forState:UIControlStateHighlighted];
    [self addSubview:rightBarBtn];
    _rightView = rightBarBtn;
    [rightBarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(iconSize.width + 30);
    }];
}

- (void)setLeftActionTitle:(NSString *)leftActionTitle {
    _leftActionTitle = leftActionTitle;
    if (_leftView) {
        [_leftView removeFromSuperview];
        _leftView = nil;
    }
    CGSize textSize = [self calculateSize:leftActionTitle];
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    leftBarBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBarBtn setTitle:leftActionTitle forState:UIControlStateNormal];
    [leftBarBtn setTitle:leftActionTitle forState:UIControlStateHighlighted];
    [leftBarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBarBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    [self addSubview:leftBarBtn];
    _leftView = leftBarBtn;
    [leftBarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        // 文字距左右边距为17
        make.width.mas_equalTo(textSize.width + 34);
    }];
}

- (void)setLeftActionIcons:(NSArray *)leftActionIcons {
    _leftActionIcons = leftActionIcons;
    if (_leftView) {
        [_leftView removeFromSuperview];
        _leftView = nil;
    }
    if (!leftActionIcons.count) {
        return;
    }
    
    UIImage *normalImage = [_leftActionIcons firstObject];
    UIImage *highlightedImage = _leftActionIcons.count > 1? [_leftActionIcons lastObject] : nil;
    CGSize iconSize = normalImage.size.width >= highlightedImage.size.width ? normalImage.size : highlightedImage.size;
    
    UIButton *leftBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarBtn.backgroundColor = [UIColor clearColor];
    [leftBarBtn addTarget:self action:@selector(leftBarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [leftBarBtn setImage:normalImage forState:UIControlStateNormal];
    [leftBarBtn setImage:highlightedImage forState:UIControlStateHighlighted];
    [self addSubview:leftBarBtn];
    _leftView = leftBarBtn;
    [leftBarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_equalTo(iconSize.width + 30);
    }];
}

- (void)setLeftView:(UIView *)leftView {
    if (_leftView) {
        [_leftView removeFromSuperview];
    }
    _leftView = leftView;
    if (leftView) {
        [self addSubview:leftView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(leftView.frame.size);
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
    }
}

- (void)setMiddleView:(UIView *)middleView {
    if (_middleView) {
        [_middleView removeFromSuperview];
    }
    _middleView = middleView;
    if (middleView) {
        [self addSubview:middleView];
        [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(middleView.frame.size);
            make.center.equalTo(self);
        }];
    }
}

- (void)setRightView:(UIView *)rightView {
    if (_rightView) {
        [_rightView removeFromSuperview];
    }
    _rightView = rightView;
    if (rightView) {
        [self addSubview:rightView];
        [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(rightView.frame.size);
            make.right.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
    }
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    _separatorLine.backgroundColor = _separatorColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    _background.image = _backgroundImage;
}

#pragma mark - actions
- (void)rightBarBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(rightBarBtnClickedOfNavigationBar:)]) {
        [self.delegate rightBarBtnClickedOfNavigationBar:self];
    }
}

- (void)leftBarBtnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(leftBarBtnClickedOfNavigationBar:)]) {
        [self.delegate leftBarBtnClickedOfNavigationBar:self];
    }
}

#pragma mark - calculateSize
- (CGSize)calculateSize:(NSString *)text {
    return [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                              context:nil].size;
}

@end
