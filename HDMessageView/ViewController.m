//
//  ViewController.m
//  HDMessageView
//
//  Created by HaKim on 16/8/4.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import "ViewController.h"
#import "HDMessageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HDMessageView *messageView = [[HDMessageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 49)];
    [self.view addSubview:messageView];
    messageView.messageArray = @[@"哈发货的哈地方呵呵呵11111"];
    
    [messageView start];
//    messageView.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
