//
//  PhotoScrollView.h
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/26.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoteViewController;
@interface PhotoScrollView : UIScrollView{
    
    NSMutableArray *imageList;
    NSInteger selectedIndex;
    id delegate_;
}
@property (nonatomic, retain) NSMutableArray *imageList;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) CGFloat clickRange;

@end

@protocol browseViewControllerDelegate <NSObject>
-(void)browseViewControllerDidTouche:(PhotoScrollView *)browseViewController Index:(NSInteger)index;
@end
