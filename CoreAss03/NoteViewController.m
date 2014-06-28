//
//  NoteViewController.m
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

// data structure ( array number/key-> type : variable name )
//  filepath: MyNotes
//      %@/thumbnail/%@@2x.png : %@ is id (for list view) (60 * 60)
//      NSMutableArray : noteArray
//          0 to N -> NSMutableDictionary : noteinfo
//                  noteid -> NSString : noteid
//                  title -> NSString : title
//                  note -> NSString : note
//                  thumbnails -> NSMutableArray : thumbnails (260 * 260)
//                      0 to N -> NSData : thumbnails
//                  photos -> NSMutableArray : photos (original size)
//                      0 to N -> NSData : photo
//
// Notes object
//    Notes note = [[Notes alloc]init];
//      note.noteid: string
//      note.title : string
//      note.note  : string
//      note.thumbnails : NSMutableArray
//      note.photos : NSMutableArray
//

#import "NoteViewController.h"

@interface NoteViewController ()

@end

@implementation NoteViewController

@synthesize titleTextField, noteTextView, singleTap, navigationBar, saveButton, noteinfo,photo, thumbnail, photoImageView, imgPicker,imagebutton, uploadimagevView ,albumController, thumbnails, photos, noteid, titleText, noteText, nn, CancelButton, EditButton, SaveButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    // Background
    UIImage *BaseImage = [UIImage imageNamed:@"note_withroll.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:BaseImage];

    
    // title
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(24, 61, 49, 21)];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont fontWithName:@"Lato-Bold" size:22];
    title.text = @"Note";
    title.textColor = [self hexToUIColor:@"ffffff" alpha:1];
    UIColor *color = [UIColor grayColor];
    title.layer.shadowColor = [color CGColor];
    title.layer.shadowRadius = 3.0f;
    title.layer.shadowOpacity = 1;
    title.layer.shadowOffset = CGSizeZero;
    title.layer.masksToBounds = NO;
    self.navigationItem.titleView = title;
    
    //NavigationBar
    UIImage *navBGImage = [UIImage imageNamed:@"header_bg.png"];
    CGFloat width = 320;
    CGFloat height = 44;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [navBGImage drawInRect:CGRectMake(0, 0, width, height)];
    navBGImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    // cancel button
    CancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    CancelButton.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:navBGImage forBarMetrics:UIBarMetricsDefault];
    
    
    // save button
    SaveButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
    SaveButton.tintColor = [UIColor whiteColor];
    
    
    // *Edit button
    EditButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(edit)];
    SaveButton.tintColor = [UIColor whiteColor];
    
    
    
    // input title
    titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 75, 280, 30)];
    titleTextField.backgroundColor = [UIColor clearColor];
    titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    titleTextField.textColor = [UIColor blueColor];
    titleTextField.placeholder = @"title";
    titleTextField.clearButtonMode = UITextFieldViewModeAlways;
    
    
    // input note
    noteTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 115, 280, 100)];
    noteTextView.backgroundColor = [UIColor clearColor];
    noteTextView.editable = YES;
    noteTextView.text = @"";
    noteTextView.layer.borderWidth = 0.4f;
    noteTextView.layer.cornerRadius = 8.0f;
    noteTextView.layer.shadowOpacity = 0.1f;
    noteTextView.layer.masksToBounds = NO;
    
    
    
    // photo
    photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    // upload photo
    UIImage *uploadimage = [UIImage imageNamed:@"upload.png"];
    CGFloat uploadimage_w = uploadimage.size.width;
    CGFloat uploadimage_h = uploadimage.size.height;
    uploadimagevView = [[UIImageView alloc]initWithImage:uploadimage];
    uploadimagevView.frame = CGRectMake(30, 230, uploadimage_w, uploadimage_h);
    
    BrowseScrollView = [[PhotoScrollView alloc] initWithFrame:CGRectMake(0, 225, self.view.bounds.size.width, uploadimage_h)];
    BrowseScrollView.backgroundColor = [UIColor clearColor];
    BrowseScrollView.pagingEnabled = NO;
    BrowseScrollView.clipsToBounds = NO;
    BrowseScrollView.delegate = self;

    
    // Button
    imagebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [imagebutton setImage:[UIImage imageNamed:@"tabbar_camera.png"] forState:UIControlStateNormal];
    [imagebutton addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchUpInside];
    [imagebutton setTitle:@"camera" forState:UIControlStateNormal];
    imagebutton.frame = CGRectMake(260, self.view.bounds.size.height-56, 50, 50);//width and height should be same value
    CGSize imageSize = imagebutton.imageView.frame.size;
    imagebutton.imageEdgeInsets = UIEdgeInsetsMake(0.0, imageSize.width/2, 0.0, 0.0);
    imagebutton.clipsToBounds = YES;
    imagebutton.layer.cornerRadius = 25;
    imagebutton.layer.borderColor=[UIColor blackColor].CGColor;
    imagebutton.layer.borderWidth=2.0f;
    
    
    
    // title
    titleText = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 280, 30)];
    // note
    CGRect rect = CGRectMake(20, 115, 280, 100);
    noteText = [[UILabel alloc]initWithFrame:rect];
    
    if(noteid == -1){
        //new
        self.navigationItem.leftBarButtonItem = CancelButton;
        self.navigationItem.rightBarButtonItem = SaveButton;
        [self.view addSubview:titleTextField];
        [self.view addSubview:noteTextView];
        [self.view addSubview:imagebutton];
    }else{
        //view and revise
        self.navigationItem.rightBarButtonItem = EditButton;
        [self.view addSubview:titleText];
        [self.view addSubview:noteText];
        
    }
    
}

- (void) addBrowseImages{
    UIImage *image = [[UIImage alloc]init];
    UIImageView *imageview = [[UIImageView alloc]init];
    CGFloat x = 0;
    for (UIView *subview in BrowseScrollView.subviews) {
        [subview removeFromSuperview];
    }
    //number of photos -1
    for (int i = 0; i < [thumbnails count]; i++) {
        x+=30;
        image = [[UIImage alloc] initWithData:[thumbnails objectAtIndex:i]];
        imageview = [[UIImageView alloc]initWithImage:image];
        imageview.frame = CGRectMake(x , 8, image.size.width, image.size.height);
        x += image.size.width;
        [BrowseScrollView addSubview:imageview];
        
    }
    BrowseScrollView.clickRange = image.size.width+8;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	noteTextView.font = [UIFont systemFontOfSize:18.0];
    
    // define single tap gesture to close keyboard
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    singleTap.delegate = self;
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];

    noteinfo = [[NSMutableDictionary alloc]init];
    photos = [[NSMutableArray alloc]init];
    thumbnails = [[NSMutableArray alloc]init];
    
    // delegate
    imgPicker = [[UIImagePickerController alloc] init];
	imgPicker.delegate = self;
    
    if(noteid != -1){
        [self getDatas];
    }

    
    if([thumbnails count] != 0 ){
        //add sumbnails
        BrowseScrollView.contentSize = CGSizeMake([thumbnails count] * 300, BrowseScrollView.frame.size.height);
        [self addBrowseImages];
        [self.view addSubview:BrowseScrollView];
    }else{
        [self.view addSubview:uploadimagevView];
    }
    
}

-(void)getDatas{
    // get notes
    NoteObj *note = (NoteObj *)[[UIApplication sharedApplication] delegate];
    nn = [note.noteArray objectAtIndex:noteid];
    titleTextField.text = nn.title;
    noteTextView.text = nn.note;
    titleText.text = nn.title;
    noteText.text = nn.note;
    photos = nn.photos;
    thumbnails = nn.thumbnails;
}

// single tap recognizer
-(void)onSingleTap:(UITapGestureRecognizer *)recognizer{

    [titleTextField resignFirstResponder];
    [noteTextView resignFirstResponder];
}
// singletap works only when keyboard opens.
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == singleTap) {
        if (titleTextField.isFirstResponder || noteTextView.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	[self.titleTextField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	if ([string length] > 0) {
		self.saveButton.enabled = YES;
	}
	else {
		self.saveButton.enabled = NO;
	}
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
	
	NSDate *date = [NSDate date];
    NoteObj *note = (NoteObj *)[[UIApplication sharedApplication] delegate];
    
    NSString *anId;
	// ID
    if(noteid == -1){
        // new
        srand( (unsigned int) time(NULL) );
        int num = rand() % 100;
        int sec = (double)[date timeIntervalSince1970];
        anId = [NSString stringWithFormat:@"%d%d", sec, num];
        //save
        [note.noteArray addObject:[NoteObj notesWithInfo:anId title:titleTextField.text note:noteTextView.text photos:photos thumbnails:thumbnails]];
    }else{
        // revise
        anId = nn.noteid;
        [note.noteArray replaceObjectAtIndex:noteid withObject:[NoteObj notesWithInfo:anId title:titleTextField.text note:noteTextView.text photos:photos thumbnails:thumbnails]];
    }

    //save photos
    if ([photos count] != 0) {
        NSData *pngTumbnail = [thumbnails objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *finalPath = [[NSString alloc]initWithFormat:@"%@/thumbnail/%@@2x.png",[note documentPath], anId];
        // Remove the filename and create the remaining path
        [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSError *error;
        BOOL success = [pngTumbnail writeToFile:[NSString stringWithFormat:@"%@/thumbnail/%@@2x.png", [note documentPath], anId] options:0 error:&error];
        if (!success) {
            NSLog(@"writeToFile failed with error %@", error);
        }else{
            NSLog(@"writeToFile success");
        }
         
    }

    NSLog(@"save");
	[note saveArray];
    
    // close
    if(noteid == -1){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self getDatas];
        [titleTextField removeFromSuperview];
        [noteTextView removeFromSuperview];
        [imagebutton removeFromSuperview];
        [self.view addSubview:titleText];
        [self.view addSubview:noteText];
        if([thumbnails count] != 0 ){
            //add sumbnails
            BrowseScrollView.contentSize = CGSizeMake([thumbnails count] * 300, BrowseScrollView.frame.size.height);
            [self addBrowseImages];
            [self.view addSubview:BrowseScrollView];
        }else{
            [BrowseScrollView removeFromSuperview];
            [self.view addSubview:uploadimagevView];
        }
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = EditButton;
    }
}

- (void)edit{
    
    [titleText removeFromSuperview];
    [noteText removeFromSuperview];
    [self.view addSubview:titleTextField];
    [self.view addSubview:noteTextView];
    [self.view addSubview:imagebutton];
    // cancel button
    UIBarButtonItem *CancelEditButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(canceledit)];
    CancelButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = CancelEditButton;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = SaveButton;
}
- (void)canceledit {
    [titleTextField removeFromSuperview];
    [noteTextView removeFromSuperview];
    [imagebutton removeFromSuperview];
    [self.view addSubview:titleText];
    [self.view addSubview:noteText];
    
    // get notes
    titleTextField.text = nn.title;
    noteTextView.text = nn.note;
    titleText.text = nn.title;
    noteText.text = nn.note;
    photos = nn.photos;
    thumbnails = nn.thumbnails;
    
    if([thumbnails count] != 0 ){
        //add sumbnails
        BrowseScrollView.contentSize = CGSizeMake([thumbnails count] * 300, BrowseScrollView.frame.size.height);
        [self addBrowseImages];
    }else{
        [BrowseScrollView removeFromSuperview];
        [self.view addSubview:uploadimagevView];
    }
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = EditButton;
}


- (void)selectPhoto{
    UIActionSheet *as = [[UIActionSheet alloc] init];
    as.delegate = self;
    as.title = @"Choose your photo";
    [as addButtonWithTitle:@"Camera"];
    [as addButtonWithTitle:@"Album"];
    [as addButtonWithTitle:@"Cancel"];
    as.cancelButtonIndex = 2;
    as.destructiveButtonIndex = 0;
    as.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [as showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet*)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0://Camera
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imgPicker.showsCameraControls = YES;
            [self presentViewController:imgPicker animated:YES completion:nil];
            break;
        case 1://Album
            //albumController is ViewController
            albumController = [[AlbumPickerViewController alloc]init];
            
            //imagePicker is UINavigationController
            ImagePickerController *imagePicker = [[ImagePickerController alloc] initWithRootViewController: albumController];
            
            albumController.photonum = 10;
            albumController.AlbumPickerDelegate = imagePicker;
            imagePicker.ImagePickerControllerDelegate = self;
            

            UIImage *navBGImage = [UIImage imageNamed:@"header_bg.png"];
            CGFloat width = 320;
            CGFloat height = 44;
            UIGraphicsBeginImageContext(CGSizeMake(width, height));
            [navBGImage drawInRect:CGRectMake(0, 0, width, height)];
            navBGImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            UINavigationBar* objectNaviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0, 320, 44)];
            [objectNaviBar setBackgroundImage:navBGImage forBarMetrics:UIBarMetricsDefault];
            [imagePicker.navigationBar setBackgroundImage:navBGImage forBarMetrics:UIBarMetricsDefault];
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            break;
    }
}
// after taking a pic or selecting a pic.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //original image
    photo = [info valueForKey:UIImagePickerControllerOriginalImage];
    thumbnail = [self imageByCroppedSqare:260];
    [imagebutton setBackgroundImage:thumbnail forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ImagePickerController:(ImagePickerController *)picker didFinishPickingMediaWithInfo:(NSMutableArray *)info {
    
    photos = [[NSMutableArray alloc]init];
    thumbnails = [[NSMutableArray alloc]init];
    // Load Albums into assetGroups
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       for (NSMutableDictionary *dic in info ) {
                           photo = [dic objectForKey:@"UIImagePickerControllerfullScreenImage"];
                           [photos addObject:UIImagePNGRepresentation(photo)];
                           thumbnail = [self imageByCroppedSqare:130];
                           [thumbnails addObject:UIImagePNGRepresentation(thumbnail)];
                       }
                       if([thumbnails count] != 0){
                           [BrowseScrollView removeFromSuperview];
                           [uploadimagevView removeFromSuperview];
                           BrowseScrollView.contentSize = CGSizeMake([thumbnails count] * 300, BrowseScrollView.frame.size.height);
                           [self addBrowseImages];
                           [self.view addSubview:BrowseScrollView];
                       }
                   });
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (UIImage *)imageByCroppedSqare:(float)point {
    
	float point2x = point*2;
	CGImageRef imageRef = [self.photo CGImage];
	size_t width = CGImageGetWidth(imageRef);
	size_t height = CGImageGetHeight(imageRef);
	float resizeHeight;
	float resizeWidth;
	BOOL isWidthLong;
    
	if (width < height) {
		resizeWidth  = point2x;
		resizeHeight = height * resizeWidth / width;
		isWidthLong = NO;
	}
	else {
		resizeHeight = point2x;
		resizeWidth  = width * resizeHeight / height;
		isWidthLong = YES;
	}
    
	UIGraphicsBeginImageContext(CGSizeMake(resizeWidth, resizeHeight));
	[self.photo drawInRect:CGRectMake(0.0, 0.0, resizeWidth, resizeHeight)];
	self.photo = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	CGRect rect = CGRectMake(0.0, 0.0, point2x, point2x);
	CGImageRef cgImage = CGImageCreateWithImageInRect(self.photo.CGImage, rect);
	UIImage *croppedImage;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
		croppedImage = [UIImage imageWithCGImage:cgImage scale:2.0 orientation:UIImageOrientationUp];
	}
	else {
		croppedImage = [UIImage imageWithCGImage:cgImage];
	}
    
	CGImageRelease(cgImage);
	return croppedImage;
}

- (void)ImagePickerControllerDidCancel:(ImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - browseViewControllerDelegate
-(void)browseViewControllerDidTouche:(PhotoScrollView *)browseViewController Index:(NSInteger)index
{
    ScrollViewController *photoviewer = [[ScrollViewController alloc]initWithNibName:nil bundle:nil];
    photoviewer.photos = photos;
    photoviewer.currentIndex = index;
    
    UINavigationController *ScrollViewNav = [[UINavigationController alloc]init];
    ScrollViewNav = [[UINavigationController alloc] initWithRootViewController:photoviewer];
    [self presentViewController:ScrollViewNav animated:YES completion:nil];
    
}


@end
