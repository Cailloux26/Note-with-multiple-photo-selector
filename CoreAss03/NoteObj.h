//
//  NoteObj.h
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/25.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteObj : NSObject{
    NSString *noteid;
    NSString *title;
    NSString *note;
    NSMutableArray *photos;
    NSMutableArray *thumbnails;
    NSMutableArray *noteArray;
}
@property (nonatomic, strong) NSString *noteid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *thumbnails;
@property (nonatomic, strong) NSMutableArray *noteArray;

+ (id)notesWithInfo:(NSString *)noteid title:(NSString *)title note:(NSString *)note photos:(NSMutableArray *)photos thumbnails:(NSMutableArray *)thumbnails;
- (NSString *)documentPath;
- (void)recoverArray;
- (void)saveArray;
@end