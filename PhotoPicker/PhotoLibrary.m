//
//  PhotoLibrary.m
//  PhotoPicker
//
//  Created by Teddy Stephenson on 3/5/13.
//  Copyright (c) 2013 Teddy Stephenson. All rights reserved.
//

#import "PhotoLibrary.h"

@implementation PhotoLibrary

- (id) init {
    
    self = [super init];
    if (self) {
        _path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
        _pictureList = [NSDictionary dictionaryWithContentsOfFile:_path];
    }
    return self;
}

- (NSUInteger)numberOfCategories {

    return self.pictureList.count;
}

- (NSString *)nameForCategory:(NSUInteger)category {
    
    NSArray* catList = [self.pictureList allKeys];
    catList = [catList sortedArrayUsingSelector:@selector(compare:)];
    return [catList objectAtIndex:category];
}

- (NSUInteger)numberOfPhotosInCategory:(NSUInteger)category {
    
    NSString* catName = [self nameForCategory:category];
    NSArray * catList = [self.pictureList valueForKey:catName];
    return catList.count;
}

- (NSString *)nameForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position {
    
    NSString* catName = [self nameForCategory:category];
    NSDictionary* currentCatagory = [self.pictureList objectForKey:catName];
    NSArray* catList = [currentCatagory allKeys];
    catList = [catList sortedArrayUsingSelector:@selector(compare:)];
    return [catList objectAtIndex:position];
}

- (UIImage *)imageForPhotoInCategory:(NSUInteger)category
                          atPosition:(NSUInteger)position {
    
    NSString* catName = [self nameForCategory:category];
    NSDictionary* currentCatagory = [self.pictureList objectForKey:catName];
    NSArray* catList = [currentCatagory allKeys];
    catList = [catList sortedArrayUsingSelector:@selector(compare:)];
    NSString* imageName = [catList objectAtIndex:position];
    NSString* imagePath = [currentCatagory valueForKey:imageName];
    return [UIImage imageNamed:imagePath];
}

@end
