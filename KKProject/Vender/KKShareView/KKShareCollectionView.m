//
//  KKShareCollectionView.m
//  KKProject
//
//  Created by 尤彬 on 2019/6/21.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKShareCollectionView.h"
#import "KKCollectionViewCell.h"

static NSString * const kkShareCollectionCellIdentifier = @"kk.Share.Collection.Cell.Identifier";
@interface KKShareCollectionCell : KKCollectionViewCell

@end

@implementation KKShareCollectionCell

-(void)kk_setupView{
    [super kk_setupView];
}

@end




@implementation KKShareCollectionView

-(void)kk_setupView{
    [super kk_setupView];
    UICollectionViewFlowLayout *flowLayout   = UICollectionViewFlowLayout.alloc.init;
    flowLayout.scrollDirection               = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing            = 0;
    flowLayout.minimumInteritemSpacing       = 0;
    flowLayout.sectionInset                  = UIEdgeInsetsZero;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.showsVerticalScrollIndicator   = false;
    self.collectionView.showsHorizontalScrollIndicator = false;
    [self.collectionView registerClass:KKShareCollectionCell.class forCellWithReuseIdentifier:kkShareCollectionCellIdentifier];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:kkShareCollectionCellIdentifier forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    KKShareCollectionCell *shareCell = (KKShareCollectionCell *)cell;
    shareCell.backgroundColor = UIColor.randomColor;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = CGRectGetHeight(collectionView.frame);
    return CGSizeMake(height,height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
