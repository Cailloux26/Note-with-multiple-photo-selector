//
//  PhotoScrollView.m
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/26.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "PhotoScrollView.h"
#import "NoteViewController.h"

@implementation PhotoScrollView
@synthesize imageList, delegate, clickRange, selectedIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    selectedIndex = location.x / 300;
    [self setNeedsDisplay];
    if([self.delegate respondsToSelector:@selector(browseViewControllerDidTouche:Index:)]){
        [self.delegate browseViewControllerDidTouche:self Index:selectedIndex];
    }
    
    
}
@end
