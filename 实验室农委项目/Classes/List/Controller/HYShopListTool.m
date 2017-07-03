//
//  HYShopListTool.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/27.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYShopListTool.h"
#import "HYGoods.h"
#import "HYShopList.h"

@interface HYShopListTool ()
@property (nonatomic, strong) NSMutableArray<HYShopList *> *lists;
@end

@implementation HYShopListTool

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray array];
    }
    return _lists;
}

/*单例模式*/
static HYShopListTool *_instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

+(instancetype)sharedListTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(id)copyWithZone:(struct _NSZone *)zone{
    return _instance;
}
#pragma mark methods
-(void)userCreateListWithItem:(HYGoods *)item{
    HYShopList *list = [[HYShopList alloc] initWithSingleItem:item];
    [self.lists addObject:list];
}
-(void)userCreateListWithItems:(NSArray *)items andTotalCost:(CGFloat) cost{
    HYShopList *list = [[HYShopList alloc] initWithItems:items andTotalCost:cost];
    [self.lists addObject:list];
}
-(NSArray *)getUserLists{
    return [self.lists copy];
}

@end
