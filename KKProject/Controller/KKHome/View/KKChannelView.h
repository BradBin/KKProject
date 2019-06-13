//
//  KKChannelView.h
//  KKProject
//
//  Created by 尤彬 on 2019/5/7.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^_Nullable KKChannelBlock)(void);
@interface KKChannelView : KKView

+(instancetype) kk_channelViewWithViewModel:(id<KKViewModelProtocol>)viewModel;
-(void) kk_showBlock:(KKChannelBlock)showBlock hideBlock:(KKChannelBlock)hideBlock;

@end

NS_ASSUME_NONNULL_END
