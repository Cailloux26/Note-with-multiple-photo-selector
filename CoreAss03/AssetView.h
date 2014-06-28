//
//  AssetView.h
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/28.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetView : UIView {
	ALAsset *asset;
	UIImageView *overlayView;
	BOOL selected;
	id AssetDelegate;
    
    UIView *activityHolderView;
    UIActivityIndicatorView *activityView;
    
}

@property (nonatomic, retain) ALAsset *asset;
@property (nonatomic, strong) id AssetDelegate;
@property (nonatomic, assign) int photonum;
-(id)initWithAsset:(ALAsset*)_asset;
-(BOOL)selected;

@end

@protocol AssetDelegate <NSObject>

- (int)totalSelectedAssets;
-(void)setTitle:(NSString*)title;
-(void)toggleSelection;
@end
