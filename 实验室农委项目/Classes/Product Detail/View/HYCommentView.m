//
//  HYCommentTableView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/10.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYCommentView.h"
#import "HYCommentCell.h"
#import "HYCommentModel.h"
#import "HYCommentTableViewCell.h"

#define commentCellIdentifier @"kComment"

@interface HYCommentView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HYCommentView
-(UITableView *)tableView{
    if (!_tableView) {
        UITableView *tb = [[UITableView alloc] initWithFrame:self.frame];
        _tableView = tb;
        [self addSubview:_tableView];
    }
    return _tableView;
}

-(NSArray *)commentArr{
    if (!_commentArr) {
        NSMutableArray *Marr = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"commentList.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        for(NSDictionary *dict in array){
            HYCommentModel *model = [[HYCommentModel alloc] initWithDict:dict];
            [Marr addObject:model];
        }
        _commentArr = [Marr copy];
    }
    return _commentArr;
}
//-(void)viewDidLoad{
//    [super viewDidLoad];
//    [self setup];
//}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

#pragma mark methods
-(void)setup{
//    self.frame = [UIScreen mainScreen].bounds;

//    [self.tableView registerClass:[HYCommentCell class] forCellReuseIdentifier:commentCellIdentifier];
//    [self.tableView registerNib:[UINib nibWithNibName:@"HYCommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentCellIdentifier];
//    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


#pragma mark - UITableViewDataSource
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//    
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HYCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier forIndexPath:indexPath];
//    HYCommentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (cell == nil) {
       HYCommentTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"HYCommentTableViewCell" owner:nil options:nil] lastObject];
//        cell = [[HYCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellIdentifier];
//    }
    cell.model = nil;
    
    cell.model = self.commentArr[indexPath.row];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

@end
