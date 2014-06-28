//
//  AlbumViewCell.m
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/27.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "AlbumViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation AlbumViewCell
@synthesize lastIndexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5, 5, self.imageView.image.size.width * self.imageView.image.scale / 3 /*[[UIScreen mainScreen] scale]*/, self.imageView.image.size.height * self.imageView.image.scale / 3 /*[[UIScreen mainScreen] scale]*/);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 5.0;
}

@end
