//
//  HYBrowserViewCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/9.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYBrowserViewCell.h"
#import "UIView+AdjustFrame.h"
@interface HYBrowserViewCell()<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HYBrowserViewCell
#pragma mark - 懒加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *sc = [[UIScrollView alloc] init];
        sc.maximumZoomScale = 2.0;
        sc.minimumZoomScale = 0.5;
        sc.delegate = self;
        _scrollView = sc;
    }
    return _scrollView;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *v = [[UIImageView alloc] init];
        _imageView = v;
    }
    return _imageView;
}
#pragma mark - init method
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - setter
-(void)setImage:(UIImage *)image{
    [self resetScrollView];
    _image = image;
    self.imageView.image = image;
    CGFloat scale = image.size.height / image.size.width;
    CGFloat height = screenWidth * scale;
    self.imageView.frame = CGRectMake(0, 0, screenWidth, height);
    if (height < [UIScreen mainScreen].bounds.size.height) {
        CGFloat offsetY = ([UIScreen mainScreen].bounds.size.height - height) * 0.5;
        self.scrollView.contentInset = UIEdgeInsetsMake(offsetY, 0, offsetY, 0);
    }else{
        self.scrollView.contentSize = CGSizeMake(screenWidth, height);
    }
}

#pragma mark - methods
-(void)setupUI{
//    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.scrollView];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.frame = [UIScreen mainScreen].bounds;
    self.scrollView.backgroundColor = [UIColor colorWithRed:61.f/255 green:140.f/255 blue:140.f/255 alpha:0.8];

}
-(void)resetScrollView{
    self.scrollView.contentSize = CGSizeZero;
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.transform = CGAffineTransformIdentity;
}
#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat offsetX = width - self.imageView.width;
    CGFloat offsetY = height - self.imageView.height;
    
    offsetX = (width - offsetX)? 0 : offsetX;
    offsetY = (height - offsetY)? 0 : offsetY;
    
    scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, offsetY, offsetX);
    
    
}


@end
