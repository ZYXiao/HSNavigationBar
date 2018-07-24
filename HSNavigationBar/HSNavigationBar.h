#import <UIKit/UIKit.h>

@protocol HSNavigationBarDelegate;

@interface HSNavigationBar : UIView

@property (nonatomic,weak) id <HSNavigationBarDelegate>delegate;

///---------------------------------------------------------------------------------------
/// @tip  快捷设置属性，通过设置这些属性可以为你创建一个view
///---------------------------------------------------------------------------------------

// middleView快捷设置，设置这个属性时，会创建一个UILabel作为middleView
@property (nonatomic,strong) NSString *title;
// righView快捷设置，设置这个属性时，会创建一个UIButton作为righView
@property (nonatomic,strong) NSString *rightActionTitle;
// righView快捷设置，设置这个属性时，会创建一个UIButton作为righView
// rightActionIcons放两个UIImage实例子，一个normal状态的image，一个highlighted状态下的image
@property (nonatomic,strong) NSArray *rightActionIcons;
// leftView快捷设置，设置这个属性时，会创建一个UIButton作为leftView
@property (nonatomic,strong) NSString *leftActionTitle;
// leftView快捷设置，设置这个属性时，会创建一个UIButton作为leftView
// 同rightActionIcons
@property (nonatomic,strong) NSArray *leftActionIcons;


///---------------------------------------------------------------------------------------
/// @tip  我们将导航栏分为3块区域，分别为leftView、middleView、righView,
///       设置这3个属性必须通过设置frame来确定它的size，origin值无效；我们将按一定的规则去布局它
///---------------------------------------------------------------------------------------

// 左侧区域视图，一般用作返回按钮。可以通过leftActionTitle或leftActionIcon属性快捷设置
@property (nonatomic,strong) UIView *leftView;
// 中间区域视图，一般用作显示标题。可以通过title属性快捷设置
@property (nonatomic,strong) UIView *middleView;
// 右侧区域视图，一般用作右侧的交互按钮。可以通过rightActionTitle或rightActionIcon属性快捷设置
@property (nonatomic,strong) UIView *rightView;


// 分隔线颜色，默认clearColor
@property (nonatomic,strong) UIColor *separatorColor;

// 背景图片，默认nil
@property (nonatomic,strong) UIImage *backgroundImage;

@end

@protocol HSNavigationBarDelegate <NSObject>
@optional
- (void)rightBarBtnClickedOfNavigationBar:(HSNavigationBar *)navBar;
- (void)leftBarBtnClickedOfNavigationBar:(HSNavigationBar *)navBar;

@end
