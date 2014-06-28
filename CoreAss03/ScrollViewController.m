//
//  ScrollViewController.m
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/05/01.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController
@synthesize photos, scrollView, previousScrollView, currentScrollView, nextScrollView, currentIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        photos = [[NSMutableArray alloc]init];
        photos = [photos init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }
    self.navigationController.navigationBarHidden = YES;
    
    // Button
    UIButton *CloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [CloseButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [CloseButton setTitle:@"Close" forState:UIControlStateNormal];
    CloseButton.frame = CGRectMake(260, 5,60,40);//width and height should be same value
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    // multiplied by the number of contents
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    

    // setup scroll views
	CGRect imageScrollViewFrame = CGRectZero;
    //w 320
	imageScrollViewFrame.size = scrollView.frame.size;
    //-320,0,320
	imageScrollViewFrame.origin.x = (currentIndex-1) * imageScrollViewFrame.size.width;
	
	CGRect imageViewFrame = CGRectZero;
	imageViewFrame.size = scrollView.frame.size;

    for (int i=0; i < 3; i++) {
        
		// image view
		UIImageView* imageView =
        [[UIImageView alloc] initWithFrame:imageViewFrame];
		imageView.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin  |
        UIViewAutoresizingFlexibleWidth       |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin   |
        UIViewAutoresizingFlexibleHeight      |
        UIViewAutoresizingFlexibleBottomMargin;
        
		// scroll view
		UIScrollView* imageScrollView =
		[[UIScrollView alloc] initWithFrame:imageScrollViewFrame];
		imageScrollView.minimumZoomScale = 1.0;
		imageScrollView.maximumZoomScale = 5.0;
		imageScrollView.showsHorizontalScrollIndicator = NO;
		imageScrollView.showsVerticalScrollIndicator = NO;
		imageScrollView.backgroundColor = [UIColor blackColor];
		
		// bind views
		[imageScrollView addSubview:imageView];
		[scrollView addSubview:imageScrollView];
        
		// assign to iVars
		switch (i) {
			case 0:
				previousScrollView = imageScrollView;
				break;
			case 1:
				currentScrollView = imageScrollView;
				break;
			case 2:
				nextScrollView = imageScrollView;
				break;
		}
		// next image
		imageScrollViewFrame.origin.x += imageScrollViewFrame.size.width;
	}
	
	scrollView.pagingEnabled = YES;
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.showsVerticalScrollIndicator = NO;
	scrollView.scrollsToTop = NO;
	
	[self adjustViews];
	[self scrollToIndex:currentIndex animated:NO];
    
    [self.view addSubview:CloseButton];
}

- (void)adjustViews
{
    // multiplied by the number of photos
	scrollView.contentSize = CGSizeMake(currentScrollView.frame.size.width * [photos count], currentScrollView.frame.size.height);
    
    // set scrollviews to each index.
	[self setImageAtIndex:currentIndex-1 toScrollView:previousScrollView];
	[self setImageAtIndex:currentIndex   toScrollView:currentScrollView];
	[self setImageAtIndex:currentIndex+1 toScrollView:nextScrollView];
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated
{
	CGPoint contentOffset = CGPointMake(index * scrollView.frame.size.width, 0);
	[scrollView setContentOffset:contentOffset animated:animated];
	
}

- (void)setImageAtIndex:(NSInteger)index toScrollView:(UIScrollView*)sv
{

	UIImageView *imageView = [sv.subviews objectAtIndex:0];
	if (index < 0 || [photos count] <= index) {
		imageView.image = nil;
		sv.delegate = nil;
		return;
	}
	UIImage *image = [[UIImage alloc]initWithData:[photos objectAtIndex:index]];
	imageView.image = image;
	imageView.contentMode = (image.size.width > image.size.height) ?
	UIViewContentModeScaleAspectFit : UIViewContentModeScaleAspectFill;
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sv
{
	CGFloat position = sv.contentOffset.x / sv.bounds.size.width;
	CGFloat delta = position - (CGFloat)currentIndex;
	
	if (fabs(delta) >= 1.0f) {
		currentScrollView.zoomScale = 1.0;
		currentScrollView.contentOffset = CGPointZero;

		if (delta > 0) {
			// the current page moved to right
			currentIndex = currentIndex+1;
			[self setupNextImage];
			
		} else {
			// the current page moved to left
			currentIndex = currentIndex-1;
			[self setupPreviousImage];
		}
		
	}
	
}
-(void)setupPreviousImage
{
    // switch scrollviews
	UIScrollView* tmpView = currentScrollView;
	currentScrollView = previousScrollView;
	previousScrollView = nextScrollView;
	nextScrollView = tmpView;
	
	CGRect frame = currentScrollView.frame;
	frame.origin.x -= frame.size.width;
	previousScrollView.frame = frame;
	[self setImageAtIndex:currentIndex-1 toScrollView:previousScrollView];
}

-(void)setupNextImage
{
    // switch scrollviews
	UIScrollView* tmpView = currentScrollView;
	currentScrollView = nextScrollView;
	nextScrollView = previousScrollView;
	previousScrollView = tmpView;
	
	CGRect frame = currentScrollView.frame;
	frame.origin.x += frame.size.width;
	nextScrollView.frame = frame;
	[self setImageAtIndex:currentIndex+1 toScrollView:nextScrollView];
}

- (void)close {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationFade;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
