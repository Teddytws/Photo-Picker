//
//  PhotoLibrary.h
//  PhotoPicker
//
//  Created by Teddy Stephenson on 3/5/13.
//  Copyright (c) 2013 Teddy Stephenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoLibrary : NSObject

@property (nonatomic) NSDictionary* pictureList;
@property (nonatomic) NSString* path;

- (NSUInteger)numberOfCategories;
- (NSString *)nameForCategory:(NSUInteger)category;
- (NSUInteger)numberOfPhotosInCategory:(NSUInteger)category;
- (NSString *)nameForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position;
- (UIImage *)imageForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position;

@end
