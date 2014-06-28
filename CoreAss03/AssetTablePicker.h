//
//  AssetTablePicker.h
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/26.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetCell.h"
#import "AssetView.h"
#import "AlbumPickerViewController.h"

@interface AssetTablePicker : UITableViewController <AssetDelegate>{
    
    UITableView *AlbumTableView;
    
    
    ALAssetsGroup *assetGroup;
	
	NSMutableArray *Assets;
	//int selectedAssets;
	
	id AssetTablePickerDelegate;
	NSOperationQueue *queue;
    
    UIView *activityHolderView;
    UIActivityIndicatorView *activityView;
    
    //page title
    UILabel *title;
    NSCache *cache;
}

@property (nonatomic, strong) id AssetTablePickerDelegate;
@property (nonatomic, retain) ALAssetsGroup *assetGroup;
@property (nonatomic, retain) NSMutableArray *Assets;
@property (nonatomic, assign) int photonum;
@property (nonatomic, assign) NSString *albumtitle;
@property (nonatomic, retain) NSMutableDictionary *albumdictionary;


@property (nonatomic, retain) NSMutableArray *_AlAssetsArr;

-(int)totalSelectedAssets;
-(void)preparePhotos;

-(void)doneAction:(id)sender;

@end

@protocol AssetTablePickerDelegate <NSObject>
-(void)selectedAssets:(NSArray*)_assets;
@end

