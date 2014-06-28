//
//  AlbumPickerViewController.h
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/26.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import "AssetTablePicker.h"
#import "AlbumViewCell.h"
#import "ImagePickerController.h"


@interface AlbumPickerViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>{
    
    UITableView *AlbumTableView;
    
	NSMutableArray *assetGroups;
	NSOperationQueue *queue;
	id AlbumPickerDelegate;
    ALAssetsLibrary *library;
    
    //BOOL albumLoaded;
    //NSArray* collection;
    NSMutableArray* albumArray;
    
}

@property (nonatomic, strong) id AlbumPickerDelegate;
@property (nonatomic, retain) NSMutableArray *assetGroups;
@property (nonatomic, assign) int photonum;
-(void)selectedAssets:(NSArray*)_assets;

@end

@protocol AlbumPickerDelegate <NSObject>
-(void)selectedAssets:(NSArray*)_assets;
-(void)cancelImagePicker;
@end
