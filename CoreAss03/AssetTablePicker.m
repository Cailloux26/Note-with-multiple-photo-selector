//
//  AssetTablePicker.m
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/26.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "AssetTablePicker.h"

@interface AssetTablePicker ()

@end

@implementation AssetTablePicker

@synthesize AssetTablePickerDelegate;
@synthesize assetGroup, Assets;
@synthesize photonum;
@synthesize albumtitle,albumdictionary;

-(void)loadView{
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    AlbumTableView = [[UITableView alloc] initWithFrame:view.bounds style:UITableViewStylePlain];
    AlbumTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    AlbumTableView.dataSource = self;
    AlbumTableView.delegate = self;
    [view addSubview:AlbumTableView];
    self.view = view;
    
}
-(void)viewDidLoad {
    
    cache = [[NSCache alloc]init];
    self.tableView = [[UITableView alloc]init];
	[self.tableView setSeparatorColor:[UIColor clearColor]];
	[self.tableView setAllowsSelection:NO];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    self.Assets = tempArray;
    
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    doneButtonItem.tintColor = [UIColor colorWithRed:0.396 green:0.580 blue:0.659 alpha:1.0];
	[self.navigationItem setRightBarButtonItem:doneButtonItem];
    
    title = [[UILabel alloc] init];
    title.text = albumtitle;
    title.frame = CGRectMake(80, 20, 200, 20);
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont fontWithName:@"URWGroteskT-LighCond" size:20];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [self.navigationItem setTitleView:title];

    [self preparePhotos];
    activityView = nil;
    activityHolderView = nil;
    
    [self.tableView reloadData];
    
    
}
-(void)preparePhotos {
    [self.navigationItem setTitle:@"Loading..."];
    void (^enumerateAsset)(ALAsset *, NSUInteger , BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop){
        if(result == nil)
        {
            [self.navigationItem setTitle:@"Pick Photos"];
            
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([self.tableView numberOfRowsInSection:0] - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:FALSE];
            return;
        }
        
        AssetView *Asset = [[AssetView alloc] initWithAsset:result];
        Asset.photonum= photonum;
        [self.Assets addObject:Asset];
        
    };
    [self.assetGroup enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:enumerateAsset];
    
}

- (void) doneAction:(id)sender {

    NSThread *progressThread = [[NSThread alloc]initWithTarget:self selector:@selector(showProgress) object:nil];
    [progressThread start];
    
    NSMutableArray *selectedAssetsImages = [[NSMutableArray alloc] init];
	for(AssetView *Asset in self.Assets)
    {
		if([Asset selected]) {
            [selectedAssetsImages addObject:[Asset asset]];
		}
	}
    [AssetTablePickerDelegate selectedAssets:selectedAssetsImages];
    
    [activityView stopAnimating];
    [activityHolderView removeFromSuperview];
    
}

- (void)showProgress{
    
    if (activityHolderView == nil) {
        activityHolderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(103, 190, 115, 101)];
        [imageView setImage:[UIImage imageNamed:@"LoadingBack.png"]];
        [activityHolderView addSubview:imageView];
    }
    if (activityView == nil) {
        activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [activityView setFrame:CGRectMake(136, 203, 50, 50)];
    }
    [activityView startAnimating];
    [activityHolderView addSubview:activityView];
    [self.navigationController.navigationBar addSubview:activityHolderView];
    
}

#pragma mark UITableViewDataSource Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ceil([self.assetGroup numberOfAssets] / 4.0);
    
}

- (NSArray*)assetsForIndexPath:(NSIndexPath*)_indexPath {
    
	int index = ((unsigned int)_indexPath.row*4);
	int maxIndex = ((unsigned int)_indexPath.row*4+3);
	if(maxIndex < [self.Assets count]) {
        
		return [NSArray arrayWithObjects:[self.Assets objectAtIndex:index],
				[self.Assets objectAtIndex:index+1],
				[self.Assets objectAtIndex:index+2],
				[self.Assets objectAtIndex:index+3],
				nil];
	}
    
	else if(maxIndex-1 < [self.Assets count]) {
        
		return [NSArray arrayWithObjects:[self.Assets objectAtIndex:index],
				[self.Assets objectAtIndex:index+1],
				[self.Assets objectAtIndex:index+2],
				nil];
	}
    
	else if(maxIndex-2 < [self.Assets count]) {
        
		return [NSArray arrayWithObjects:[self.Assets objectAtIndex:index],
				[self.Assets objectAtIndex:index+1],
				nil];
	}
    
	else if(maxIndex-3 < [self.Assets count]) {
        
		return [NSArray arrayWithObject:[self.Assets objectAtIndex:index]];
	}
    
	return nil;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    AssetCell *cell = (AssetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[AssetCell alloc] initWithAssets:[self assetsForIndexPath:indexPath] reuseIdentifier:CellIdentifier];
    }
	else
    {
        cell = [[AssetCell alloc] initWithAssets:[self assetsForIndexPath:indexPath] reuseIdentifier:CellIdentifier];
		//[cell setAssets:[self assetsForIndexPath:indexPath]];
	}
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	return 79;
}

- (int)totalSelectedAssets {
    
    int count = 0;
    
    for(AssetView *asset in self.Assets)
    {
        asset.AssetDelegate = self;
		if([asset selected])
        {
            count++;
		}
	}
    
    return count;
}
-(void)selectedAssets:(NSArray*)assests;{
}

-(void)toggleSelection{
    
}

- (void)dealloc
{
    activityView = nil;
    activityHolderView = nil;
}

@end

