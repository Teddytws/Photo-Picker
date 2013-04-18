//
//  PickerViewController.m
//  PhotoPicker
//
//  Created by Teddy Stephenson on 3/5/13.
//  Copyright (c) 2013 Teddy Stephenson. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "PickerViewController.h"
#import "PhotoLibrary.h"


#define CATAGORY_SIDE 0

@interface PickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) PhotoLibrary* photoList;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic) int currentSelectedCat;
@property (nonatomic) NSString* currentSelectedPic;
@property (strong, nonatomic) IBOutlet UIImageView *imagePicked;
- (IBAction)alphaSlider:(UISlider *)sender;
@property (nonatomic) SystemSoundID soundId;


@end

@implementation PickerViewController

- (PhotoLibrary *)photoList {
    
    if (!_photoList) {
        _photoList = [[PhotoLibrary alloc]init];
    }
    return _photoList;
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == CATAGORY_SIDE) {
        return self.photoList.numberOfCategories;
    }
    else
        return [self.photoList numberOfPhotosInCategory:self.currentSelectedCat];
}

#pragma mark - UIPickerViewDelegate
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == CATAGORY_SIDE)
        return [self.photoList nameForCategory:row];
    else
        return [self.photoList nameForPhotoInCategory:self.currentSelectedCat atPosition:row
                ];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if(component == CATAGORY_SIDE) {
        self.currentSelectedCat = row;
        [pickerView reloadAllComponents];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        self.imagePicked.image = [self.photoList imageForPhotoInCategory:self.currentSelectedCat atPosition:0];
        AudioServicesPlaySystemSound(self.soundId);
    }
    else {
        self.imagePicked.image = [self.photoList imageForPhotoInCategory:self.currentSelectedCat atPosition:row];
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    }
    
}

#pragma mark - Slider
- (IBAction)alphaSlider:(UISlider *)sender {
    
    self.imagePicked.alpha = sender.value;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //THIS TOOK FOREVER TO FIGURE OUT!!!!!!
    NSURL *tapUrl   = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"saber" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)tapUrl, &_soundId);
}


@end
