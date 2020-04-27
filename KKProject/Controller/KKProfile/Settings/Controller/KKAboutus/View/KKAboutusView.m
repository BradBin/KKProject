//
//  KKAboutusView.m
//  KKProject
//
//  Created by youbin on 2019/11/24.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKAboutusView.h"
#import "KKAboutusHeader.h"
#import "KKAboutusCell.h"
#import "KKAboutusViewModel.h"

@interface KKAboutusView ()

@property (nonatomic, strong) KKAboutusViewModel *viewModel;
@property (nonatomic, strong) KKAboutusHeader    *header;

@end
@implementation KKAboutusView

- (instancetype)initWithViewModel:(id<KKViewModelProtocol>)viewModel{
    _viewModel = viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)kk_setupView{
    [super kk_setupView];
    self.header = ({
        KKAboutusHeader *view = [[KKAboutusHeader alloc] initWithViewModel:self.viewModel];
        view.frame = CGRectMake(0, 0,KKScreenWidth(), KKAboutusHeaderHeight());
        view.backgroundColor = UIColor.redColor;
        view.scrollView = self.collectionView;
        [self addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(view.superview.mas_top);
//            make.centerX.equalTo(view.superview.mas_centerX);
//            make.width.equalTo(view.superview.mas_width);
//            make.height.mas_equalTo(KKAboutusHeaderHeight());
//        }];
//        [view.superview layoutIfNeeded];
        view;
    });
    
    [self.collectionView registerClass:KKAboutusCell.class forCellWithReuseIdentifier:KKAboutusCellIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:KKAboutusCellIdentifier forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"willDisplayCell : %ld",indexPath.item);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didEndDisplayingCell : %ld",indexPath.item);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(KKScreenWidth(), KKScreenWidth() * 0.5);
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
