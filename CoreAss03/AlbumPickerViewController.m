//
//  AlbumPickerViewController.m
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/26.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "AlbumPickerViewController.h"

@interface AlbumPickerViewController ()

@end

@implementation AlbumPickerViewController

@synthesize AlbumPickerDelegate;
@synthesize assetGroups, photonum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView{
    // create tableView
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    AlbumTableView = [[UITableView alloc] initWithFrame:view.bounds style:UITableViewStylePlain];
    AlbumTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    AlbumTableView.dataSource = self;
    AlbumTableView.delegate = self;
    [view addSubview:AlbumTableView];
    self.view = view;
    
    
    // create cancel button and set cancelImagePicker to close picker
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:AlbumPickerDelegate action:@selector(cancelImagePicker)];
    cancelButton.tintColor = [UIColor colorWithRed:0.396 green:0.580 blue:0.659 alpha:1.0];
	[self.navigationItem setRightBarButtonItem:cancelButton];
    
    
    //init
    albumArray = [[NSMutableArray alloc]init];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    self.assetGroups = tempArray;
    
    library = [[ALAssetsLibrary alloc] init];
    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       // Group enumerator Block
                       void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop)
                       {
                           if (group == nil)
                           {
                               // if there is no album, call reloadTableView
                               [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
                               return;
                           }
                           // if there is album, get these names and assign them to assetGroups
                           NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:2];
                           [dic setObject:group forKey:@"group"];
                           NSString *name = [[group valueForProperty:ALAssetsGroupPropertyName] lowercaseString];
                           if ([name isEqualToString:@"saved photos"]) {
                               name = @"-4";
                           }else if ([name isEqualToString:@"camera roll"]){
                               name = @"-3";
                           }else if ([name isEqualToString:@"photo stream"]){
                               name = @"-2";
                           }else if ([name isEqualToString:@"photo library"]){
                               name = @"-1";
                           }else {
                               name = [NSString stringWithFormat:@"0%@",name];
                           }
                           [dic setObject:name forKey:@"name"];
                           [self.assetGroups addObject:dic];
                           
                           
                       };
                       
                       // Group Enumerator Failure Block
                       void (^assetGroupEnumeratorFailure)(NSError *) = ^(NSError *error) {
                           UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Information" message:[NSString stringWithFormat:@"Please enable location services from device settings."] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                           [alert show];
                           
                       };
                       
                       [library enumerateGroupsWithTypes:ALAssetsGroupAll
                                              usingBlock:assetGroupEnumerator
                                            failureBlock:assetGroupEnumeratorFailure];
                       
                   });
}
-(void)reloadTableView {
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.assetGroups = [NSMutableArray arrayWithArray:[self.assetGroups sortedArrayUsingDescriptors:sortDescriptors]];
    
	[AlbumTableView reloadData];
    
    self.photonum = photonum;
    //[self loadLastViewdAlbum];
}
/*
- (void)loadLastViewdAlbum{
    if (!albumLoaded) {
        NSString *lastViewedAlbum = [[NSUserDefaults standardUserDefaults] valueForKey:@"album"];
        if ([lastViewedAlbum length] > 0) {
            int row = [lastViewedAlbum intValue];
            if (row < [self.assetGroups count]) {
                AssetTablePicker *picker = [[AssetTablePicker alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
                picker.AssetTablePickerDelegate = self;
                picker.photonum = photonum;
                
                NSMutableDictionary *dic = [self.assetGroups objectAtIndex:row];
                picker.assetGroup = [dic valueForKey:@"group"];
                [picker.assetGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
                [self.navigationController pushViewController:picker animated:NO];
                albumLoaded = TRUE;
            }
        }
    }
    
}
 */

-(void)selectedAssets:(NSArray*)_assets{
	
    [AlbumPickerDelegate selectedAssets:_assets];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [assetGroups count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",0];
    AlbumViewCell *cell = [[AlbumViewCell alloc]init];
    if (cell == nil) {
        cell = [[AlbumViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //define style of cell
    cell.textLabel.frame = CGRectMake(70, 25, 200, 20);
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"URWGroteskT-LighCond" size:14];
    cell.textLabel.textColor = [self hexToUIColor:@"00000" alpha:1];

    //get Album lists from assetGroups and set these names to cell.text
    NSMutableDictionary *dic = [assetGroups objectAtIndex:indexPath.row];

    ALAssetsGroup *g = (ALAssetsGroup*)[dic valueForKey:@"group"];
    
    [g setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger gCount = [g numberOfAssets];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d)",[g valueForProperty:ALAssetsGroupPropertyName], gCount];
    [cell.imageView setImage:[UIImage imageWithCGImage:[g posterImage]]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //AssetTablePicker *picker = [[AssetTablePicker alloc] initWithNibName:nil bundle:nil];
    AssetTablePicker *picker = [[AssetTablePicker alloc] initWithNibName:nil bundle:nil];
    picker.AssetTablePickerDelegate = self;
    picker.photonum = photonum;

    NSMutableDictionary *dic = [assetGroups objectAtIndex:indexPath.row];
    picker.assetGroup = [dic valueForKey:@"group"];
    [picker.assetGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    ALAssetsGroup *g = (ALAssetsGroup*)[dic valueForKey:@"group"];
    picker.albumtitle = [g valueForProperty:ALAssetsGroupPropertyName];
    [self.navigationController pushViewController:picker animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 58;
}

-(UIColor*) hexToUIColor:(NSString *)hex alpha:(CGFloat)a{
	NSScanner *colorScanner = [NSScanner scannerWithString:hex];
	unsigned int color;
	[colorScanner scanHexInt:&color];
	CGFloat r = ((color & 0xFF0000) >> 16)/255.0f;
	CGFloat g = ((color & 0x00FF00) >> 8) /255.0f;
	CGFloat b =  (color & 0x0000FF) /255.0f;
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [AlbumTableView deselectRowAtIndexPath:[AlbumTableView indexPathForSelectedRow] animated:YES];
    
    [AlbumTableView reloadData];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [AlbumTableView flashScrollIndicators];
    
}
- (void)setEditing:(BOOL)flag animated:(BOOL)animated {
    
    [super setEditing:flag animated:animated];
    
    [AlbumTableView setEditing:flag animated:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
