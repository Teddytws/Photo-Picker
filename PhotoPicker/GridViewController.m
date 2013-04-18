//
//  GridViewController.m
//  PhotoPicker
//
//  Created by Teddy Stephenson on 3/5/13.
//  Copyright (c) 2013 Teddy Stephenson. All rights reserved.
//


#import "GridViewController.h"
#import "PhotoLibrary.h"
#import "PhotoHeaderView.h"
#import "PhotoCell.h"



@interface GridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) PhotoLibrary* photoList;
@property (nonatomic) SystemSoundID soundId;
@property (weak, nonatomic) IBOutlet UILabel *pictureName;
@end

@implementation GridViewController

- (PhotoLibrary *) photoList {
    
    if (!_photoList) {
        _photoList = [[PhotoLibrary alloc]init];
    }
    return _photoList;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return [self.photoList numberOfCategories];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.photoList numberOfPhotosInCategory:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell* cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    cell.photoImage.image = [self.photoList imageForPhotoInCategory:indexPath.section atPosition:indexPath.row];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    PhotoHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    headerView.catagoryName.text = [self.photoList nameForCategory:indexPath.section];
    return headerView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.pictureName.text = [self.photoList nameForPhotoInCategory:indexPath.section atPosition:indexPath.row];
    AudioServicesPlaySystemSound(_soundId);

}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    //THIS TOOK FOREVER TO FIGURE OUT!!!!!!
    NSURL *tapUrl   = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"LAZER" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)tapUrl, &_soundId);
}



@end
