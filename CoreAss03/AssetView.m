//
//  AssetView.m
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/28.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//
#import "AssetView.h"
#import "AssetTablePicker.h"

@implementation AssetView

@synthesize asset;
@synthesize AssetDelegate;
@synthesize photonum;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

-(id)initWithAsset:(ALAsset*)_asset {
	
	if (self = [super initWithFrame:CGRectMake(0, 0, 0, 0)]) {
		photonum = 10;
		self.asset = _asset;
		
		CGRect viewFrames = CGRectMake(0, 0, 75, 75);
		
		UIImageView *assetImageView = [[UIImageView alloc] initWithFrame:viewFrames];
		[assetImageView setContentMode:UIViewContentModeScaleToFill];
		[assetImageView setImage:[UIImage imageWithCGImage:[self.asset thumbnail]]];
		[self addSubview:assetImageView];
		
		overlayView = [[UIImageView alloc] initWithFrame:viewFrames];
		[overlayView setImage:[UIImage imageNamed:@"Overlay.png"]];
		[overlayView setHidden:YES];
		[self addSubview:overlayView];
    }
    
	return self;
}

-(void)toggleSelection {
    
	overlayView.hidden = !overlayView.hidden;
    //
    //    if([(ELCAssetTablePicker*)self.parent totalSelectedAssets] >= 10) {
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Maximum Reached" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    //		[alert show];
    //		[alert release];
    //
    //        [(ELCAssetTablePicker*)self.parent doneAction:nil];
    //    }
    int totalAssets = [(AssetTablePicker*)self.AssetDelegate totalSelectedAssets];
    if(totalAssets <= photonum) {
        [(AssetTablePicker*)self.AssetDelegate setTitle:[NSString stringWithFormat:@"%d more",(photonum - totalAssets)]];
    }else {
        overlayView.hidden = TRUE;
    }
    
}

-(BOOL)selected {
	
	return !overlayView.hidden;
}

-(void)setSelected:(BOOL)_selected {
    
	[overlayView setHidden:!_selected];
}

- (void)dealloc
{
    self.asset = nil;
}

@end

