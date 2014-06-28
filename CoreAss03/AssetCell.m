//
//  AssetCell.m
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/28.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "AssetCell.h"
#import "AssetView.h"

@implementation AssetCell

@synthesize rowAssets;

-(id)initWithAssets:(NSArray*)_assets reuseIdentifier:(NSString*)_identifier {
    
	if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier]) {
        
		self.rowAssets = _assets;
	}
	
	return self;
}

-(void)setAssets:(NSArray*)_assets {
	
	for(UIView *view in [self subviews])
    {
		[view removeFromSuperview];
	}
	self.rowAssets = _assets;
}

-(void)layoutSubviews {
    
	CGRect frame = CGRectMake(4, 2, 75, 75);
	
	for(AssetView *Assetview in self.rowAssets) {
		
		[Assetview setFrame:frame];
		[Assetview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:Assetview action:@selector(toggleSelection)]];
		[self addSubview:Assetview];
		
		frame.origin.x = frame.origin.x + frame.size.width + 4;
	}
}

-(void)dealloc
{
}

@end
