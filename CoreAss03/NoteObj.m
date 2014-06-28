//
//  NoteObj.m
//  CoreAss03
//
//  Created by Tanaka Koichi on 2014/04/25.
//  Copyright (c) 2014年 Tanaka Koichi. All rights reserved.
//
#import "NoteObj.h"

@implementation NoteObj

@synthesize noteid,title,note,photos,thumbnails, noteArray;
+ (id)notesWithInfo:(NSString *)noteid title:(NSString *)title note:(NSString *)note photos:(NSMutableArray *)photos thumbnails:(NSMutableArray *)thumbnails
{
    NoteObj *newNote = [[self alloc] init];
	newNote.noteid = noteid;
	newNote.title = title;
    newNote.note = note;
    newNote.photos = photos;
    newNote.thumbnails = thumbnails;
    
	return newNote;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        noteid = [decoder decodeObjectForKey:@"noteid"];
        title = [decoder decodeObjectForKey:@"title"];
        note = [decoder decodeObjectForKey:@"note"];
        photos = [decoder decodeObjectForKey:@"photos"];
        thumbnails = [decoder decodeObjectForKey:@"thumbnails"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:noteid forKey:@"noteid"];
    [encoder encodeObject:title forKey:@"title"];
    [encoder encodeObject:note forKey:@"note"];
    [encoder encodeObject:photos forKey:@"photos"];
    [encoder encodeObject:thumbnails forKey:@"thumbnails"];

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
	BOOL res = [NSKeyedArchiver archiveRootObject: self.noteArray toFile:path];
    if(res){
        NSLog(@"success");
    }
}
- (void)dealloc
{
    self.noteid = nil;
    self.title = nil;
    self.note = nil;
    self.photos = nil;
    self.thumbnails = nil;
}

@end