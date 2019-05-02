//
//  KKCollectionView.h
//  ot-dayu
//
//  Created by 尤彬 on 2019/3/1.
//  Copyright © 2019 YangCK. All rights reserved.
//

#import "KKView.h"
#import "KKCollectionViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@class _KKCollectionView;
@interface KKCollectionView : UIView<KKCollectionViewProtocol,
                                     UICollectionViewDelegate,
                                     UICollectionViewDataSource,
                                     UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) _KKCollectionView *collectionView;
@property(nonatomic,assign) BOOL loading; //default is false

@end



@interface _KKCollectionView : UICollectionView

@end

NS_ASSUME_NONNULL_END
