//
//  AppDelegate.m
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate
@synthesize noteArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NoteObj *note = (NoteObj *)[[UIApplication sharedApplication] delegate];
    [note recoverArray];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[MainViewController alloc] init];
    } else {
        self.viewController = [[MainViewController alloc] init];
    }
    UINavigationController *NoteViewNav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = NoteViewNav;
    [self.window makeKeyAndVisible];

    return YES;
}

- (NSMutableArray *)noteArray {
	
	if (noteArray != nil) {
		return noteArray;
	}
	noteArray = [[NSMutableArray alloc] initWithCapacity:20];
	return noteArray;
}

//get documetPath use NSDocumentDirectory defined in NSPathUtilities.h
- (NSString *)documentPath {
    //NSUserDomainMask is homedirectory
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

//get note data
- (void)recoverArray {
    
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *path = [[self documentPath] stringByAppendingPathComponent:@"MyNotes"];
	
	if ([fileManager isReadableFileAtPath:path]) {
		NSMutableArray *recoveredArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
		self.noteArray = recoveredArray;
	}
    
}

//Save noteArray
- (void)saveArray {
	NSString *path = [[self documentPath] stringByAppendingPathComponent:@"MyNotes"];
	[NSKeyedArchiver archiveRootObject: self.noteArray toFile:path];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NoteObj *note = (NoteObj *)[[UIApplication sharedApplication] delegate];
    [note saveArray];
}
@end
