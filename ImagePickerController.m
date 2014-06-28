//
//  ImagePickerController.m
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/26.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "ImagePickerController.h"

@interface ImagePickerController ()

@end

@implementation ImagePickerController

@synthesize ImagePickerControllerDelegate;

-(void)cancelImagePicker {
	if([ImagePickerControllerDelegate respondsToSelector:@selector(ImagePickerControllerDidCancel:)]) {
		[ImagePickerControllerDelegate performSelector:@selector(ImagePickerControllerDidCancel:) withObject:self];
	}
}

-(void)selectedAssets:(NSArray*)_assets{
    
	NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    for(ALAsset *asset in _assets) {
        
        NSMutableDictionary *tmpdic = [[NSMutableDictionary alloc] init];
        [tmpdic setObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]] forKey:@"UIImagePickerControllerfullScreenImage"];
        [returnArray addObject:tmpdic];
    }
	if([ImagePickerControllerDelegate respondsToSelector:@selector(ImagePickerController:didFinishPickingMediaWithInfo:)]) {
		[ImagePickerControllerDelegate performSelector:@selector(ImagePickerController:didFinishPickingMediaWithInfo:) withObject:self withObject:[NSArray arrayWithArray:returnArray]];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
}

@end