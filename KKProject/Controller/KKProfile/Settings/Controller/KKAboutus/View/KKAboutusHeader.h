//
//  KKAboutusHeader.h
//  KKProject
//
//  Created by youbin on 2019/11/24.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKView.h"

NS_ASSUME_NONNULL_BEGIN

static inline CGFloat KKAboutusHeaderHeight(){
    return (UIScreen.mainScreen.bounds.size.height * 0.3);
}

@interface KKAboutusHeader : KKView

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) CGFloat offsetY;
@property (nonatomic, copy) void(^KKCallBack)(CGFloat offsetY);
- (void)updateSubViewsWithScrollOffset:(CGPoint)offset;

@end

NS_ASSUME_NONNULL_END
