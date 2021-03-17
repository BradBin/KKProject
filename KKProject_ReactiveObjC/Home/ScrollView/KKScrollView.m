//
//  KKScrollView.m
//  KKProject_ReactiveObjC
//
//  Created by youbin on 2020/7/6.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

#import "KKScrollView.h"
#import "KKTableView.h"

@interface KKScrollView ()<UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) UIScrollView *backgroudView;
@property (nonatomic, strong) KKTableView  *tableView;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation KKScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    self.backgroudView = ({
        UIScrollView *view = UIScrollView.new;
        view.delegate = self;
        view.alwaysBounceVertical = false;
        view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        view.backgroundColor = UIColor.orangeColor;
        view.contentInset = UIEdgeInsetsMake(0, 0, 34, 0);
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view.superview);
        }];
        view;
    });
    
    self.headerView = ({
        UIView *view = UIView.new;
        view.backgroundColor = UIColor.purpleColor;
        [self.backgroudView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.superview.mas_top);
            make.centerX.equalTo(view.superview);
            make.width.equalTo(view.superview);
            make.height.mas_equalTo(300);
        }];
        view;
    });
    
    self.tableView = ({
        KKTableView *view = KKTableView.new;
        view.delegate = self;
        view.dataSource = self;
        view.backgroundColor = UIColor.redColor;
        [self.backgroudView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerView.mas_bottom);
            make.centerX.equalTo(view.superview);
            make.width.equalTo(view.superview);
            make.height.mas_equalTo(1000);
        }];
        view;
    });
    
    [self.backgroudView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tableView.mas_bottom);
    }];

}


#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
}




#pragma mark -UITableViewDelegate/UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@" section: %ld -- row: %ld",indexPath.section,indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
