//
//  KKImageZoomView.h
//  KKProject
//
//  Created by Macbook Pro 15.4  on 2019/6/30.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KKImageZoomView;
@protocol KKImageZoomViewDelegate <NSObject>
- (void)tapImageZoomView;
- (void)imageViewDidZoom:(KKImageZoomView *)zoomView;
@end


@interface KKImageZoomView : UIScrollView

@property(nonatomic,     weak)id<KKImageZoomViewDelegate>zoomViewDelegate;
@property(nonatomic,strong,readonly)YYAnimatedImageView *imageView;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,  copy)NSString *imageUrl;
- (void)showImageWithUrl:(NSString *)imageUrl placeHolder:(UIImage *)image;
- (void)clear;

@end

NS_ASSUME_NONNULL_END
