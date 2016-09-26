
#import <UIKit/UIKit.h>

/** 引用 **/

/** cell模型类型 **/
typedef enum {
    LYLoadTypeNew,
    LYLoadTypeMore
} LYLoadType;

// 圆角半径
UIKIT_EXTERN NSInteger const kLYCornerRadius;

// 动画时间
UIKIT_EXTERN CGFloat const kAnimationTime;

/** 导航栏的高度 **/
UIKIT_EXTERN CGFloat const LYNavBarHeight;

/** 顶部标签栏的高度 **/
UIKIT_EXTERN CGFloat const LYTitlesViewH;

/** 首页顶部标题栏数据 **/
UIKIT_EXTERN NSString const * LYTitlesViewURL;

/** 首页单元格的行高 */
UIKIT_EXTERN CGFloat const LYHomeCellHeight;

UIKIT_EXTERN NSString const * isLogin;

UIKIT_EXTERN CGFloat const kMargin;
