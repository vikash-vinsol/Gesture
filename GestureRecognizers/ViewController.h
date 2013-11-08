//
//  ViewController.h
//  GestureRecognizers
//
//  Created by Ole Begemann on 24.01.12.
//  Copyright (c) 2012 Ole Begemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareViewController.h"


@interface ViewController : UIViewController<UIGestureRecognizerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
}
@property(nonatomic,strong) UIImagePickerController *picker;
@property (nonatomic,weak) UIImageView *imageSelected;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UIImageView *cameraBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *settingBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *settingView;
@property (assign) BOOL cameraSelectionBool;
@property (weak,nonatomic) UIImage *imageShare;

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer;
- (IBAction)customBackgroundAction:(id)sender;
- (IBAction)buttonAction:(id)sender;
- (IBAction)CancelButtonCLick:(id)sender;

@end
