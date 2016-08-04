//
//  HDMessageView.h
//  HDMessageView
//
//  Created by HaKim on 16/8/4.
//  Copyright © 2016年 haKim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDMessageView : UIView

@property (nonatomic, copy) NSArray *messageArray;

- (void)start;
- (void)stop;

@end
