//
//  ImagePickerController.h
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/26.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetView.h"
#import "AssetCell.h"
#import "AssetTablePicker.h"
#import "AlbumPickerViewController.h"

@interface ImagePickerController : UINavigationController{
    id ImagePickerControllerDelegate;
}

@property (nonatomic, strong) id ImagePickerControllerDelegate;
-(void)selectedAssets:(NSArray*)_assets;
-(void)cancelImagePicker;

@end

@protocol ImagePickerControllerDelegate

- (void)ImagePickerController:(ImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)ImagePickerControllerDidCancel:(ImagePickerController *)picker;

@end