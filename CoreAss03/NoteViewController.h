//
//  NoteViewController.h
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickerController.h"
#import "PhotoScrollView.h"
#import "AlbumPickerViewController.h"
#import "NoteObj.h"
#import "ScrollViewController.h"

@class PhotoScrollView;
@interface NoteViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, browseViewControllerDelegate> {
    
    // for input
    UITextField *titleTextField;
    UITextView *noteTextView;
    UINavigationBar *navigationBar;
	UIBarButtonItem *saveButton;
    NSMutableDictionary *noteinfo;
    NSMutableArray *photos;
    NSMutableArray *thumbnails;
    
    UIImage *photo;
	UIImage *thumbnail;
	UIImageView *photoImageView;
    UIImagePickerController *imgPicker;
    UIButton *imagebutton;
    
    //for view and edit
    UILabel *titleText;
    UILabel *noteText;
    NoteObj *nn;
    
    //browse photos
    PhotoScrollView *BrowseScrollView;
    UIImageView *uploadimagevView;
    
    AlbumPickerViewController *albumController;
    
    UIBarButtonItem* CancelButton;
    UIBarButtonItem* EditButton;
    UIBarButtonItem* SaveButton;
}

@property (nonatomic, retain) UITextField *titleTextField;
@property (nonatomic, retain) UITextView *noteTextView;
@property (nonatomic, retain) UINavigationBar *navigationBar;
@property (nonatomic, retain) UIBarButtonItem *saveButton;
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, retain) NSMutableDictionary *noteinfo;
@property (nonatomic, retain) NSMutableArray *photos;
@property (nonatomic, retain) NSMutableArray *thumbnails;
@property (nonatomic, retain) UIImage *photo;
@property (nonatomic, retain) UIImage *thumbnail;
@property (nonatomic, retain) UIImageView *photoImageView;
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (nonatomic, retain) UIButton *imagebutton;

@property (nonatomic, retain) UIBarButtonItem *CancelButton;
@property (nonatomic, retain) UIBarButtonItem *EditButton;
@property (nonatomic, retain) UIBarButtonItem *SaveButton;

// for view and edit
@property (nonatomic) NSInteger noteid;
@property (nonatomic, retain) UIImageView *uploadimagevView;
@property (nonatomic, retain) UILabel *titleText;
@property (nonatomic, retain) UILabel *noteText;
@property (nonatomic, retain) NoteObj *nn;

@property (nonatomic, retain) AlbumPickerViewController *albumController;

- (void)cancel;
- (void)save;
- (UIImage *)imageByCroppedSqare:(float)length;

@end
