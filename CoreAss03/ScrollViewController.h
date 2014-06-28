//
//  ScrollViewController.h
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/05/01.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewController : UIViewController<UIScrollViewDelegate>
{
    NSMutableArray* photos;
    
    UIScrollView *scrollView;
    UIScrollView *previousScrollView;
    UIScrollView *currentScrollView;
    UIScrollView *nextScrollView;
    
    NSInteger currentIndex;
    
}
@property (nonatomic, retain) NSMutableArray *photos;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIScrollView *previousScrollView;
@property (nonatomic, retain) UIScrollView *currentScrollView;
@property (nonatomic, retain) UIScrollView *nextScrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@end
