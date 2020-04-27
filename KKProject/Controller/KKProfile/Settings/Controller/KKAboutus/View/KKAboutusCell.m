//
//  KKAboutusCell.m
//  KKProject
//
//  Created by youbin on 2019/11/24.
//  Copyright © 2019 Macbook Pro 15.4 . All rights reserved.
//

#import "KKAboutusCell.h"

NSString *const KKAboutusCellIdentifier = @"KK.Aboutus.Cell.Identifier";
@implementation KKAboutusCell

-(void)kk_setupView{
    [super kk_setupView];
    self.contentView.backgroundColor = UIColor.randomColor;
}

@end
