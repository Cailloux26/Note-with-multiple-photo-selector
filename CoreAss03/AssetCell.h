//
//  AssetCell.h
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/28.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetView.h"

@interface AssetCell : UITableViewCell
{
	NSArray *rowAssets;
}
-(id)initWithAssets:(NSArray*)_assets reuseIdentifier:(NSString*)_identifier;
-(void)setAssets:(NSArray*)_assets;

@property (nonatomic,retain) NSArray *rowAssets;

@end