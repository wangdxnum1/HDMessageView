//
//  HDMessageView.m
//  HDMessageView
//
//  Created by HaKim on 16/8/4.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "HDMessageView.h"

@interface HDMessageView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIButton *topBtn;

@property (nonatomic, weak) UIButton *centerBtn;

@property (nonatomic, weak) UIButton *bottomBtn;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HDMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * 3);
}

- (void)messageBtnClicked:(UIButton*)sender{
    NSLog(@"i = %ld clicked",self.currentIndex);
}

- (void)scrollMessageBtn:(NSTimer*)time{
    ++self.currentIndex;
    [self.scrollView setContentOffset:CGPointMake(0, self.frame.size.height * 2) animated:YES];
}

- (void)start{
    [self.timer invalidate];
    
    if(self.messageArray.count == 0){
        return;
    }
    
    [self setDefaultMessage];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollMessageBtn:) userInfo:nil repeats:YES];
}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setDefaultMessage{
    NSInteger centerIndex = self.currentIndex % self.messageArray.count;
    NSInteger nextIndex = (self.currentIndex + 1) % self.messageArray.count;
    NSInteger previousIndex = (self.currentIndex - 1 + self.messageArray.count) % self.messageArray.count;
    
    [self.topBtn setTitle:self.messageArray[previousIndex] forState:UIControlStateNormal];
    [self.centerBtn setTitle:self.messageArray[centerIndex] forState:UIControlStateNormal];
    [self.bottomBtn setTitle:self.messageArray[nextIndex] forState:UIControlStateNormal];
}

#pragma mark - UI

- (void)commonInit{
    [self setupScrollView];
    [self setupButtons];
    
    self.currentIndex = 0;
}

- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = NO;
    scrollView.delegate = self;
    
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    scrollView.backgroundColor = [UIColor redColor];
    
    [scrollView setContentOffset:CGPointMake(0, self.frame.size.height) animated:NO];
    
    self.scrollView = scrollView;
    [self addSubview:scrollView];
}

- (void)setupButtons{
    for (int i = 0; i < 3; ++i) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.frame = CGRectMake(0, self.frame.size.height * i, self.frame.size.width, self.frame.size.height);
        [btn addTarget:self action:@selector(messageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        if(i == 0){
            self.topBtn = btn;
        }else if(i == 1){
            self.centerBtn = btn;
        }else{
            self.bottomBtn = btn;
        }
    }
}

#pragma mark - 图片停止时,调用该函数使得滚动视图复用

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger centerIndex = self.currentIndex % self.messageArray.count;
    NSInteger nextIndex = (self.currentIndex + 1) % self.messageArray.count;
    NSInteger previousIndex = (self.currentIndex - 1 + self.messageArray.count) % self.messageArray.count;
    
    self.currentIndex = centerIndex;
    
    [self.topBtn setTitle:self.messageArray[previousIndex] forState:UIControlStateNormal];
    [self.centerBtn setTitle:self.messageArray[centerIndex] forState:UIControlStateNormal];
    [self.bottomBtn setTitle:self.messageArray[nextIndex] forState:UIControlStateNormal];
    
    self.scrollView.contentOffset = CGPointMake(0, self.frame.size.height);
}

@end
