//
//  MainViewController.h
//  CoreAss02
//
//  Created by Tanaka Koichi on 2014/04/22.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteViewController.h"
#import "NoteObj.h"

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate>{
    UITableView *tableView;
    NoteViewController *noteViewController;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NoteViewController *noteViewController;
@end


