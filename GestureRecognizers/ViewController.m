//
//  ViewController.m
//  GestureRecognizers
//
//  Created by Ole Begemann on 24.01.12.
//  Copyright (c) 2012 Ole Begemann. All rights reserved.
//

#import "ViewController.h"
#import "ShareViewController.h"

@implementation ViewController

{
   UIImage *viewImage;
    
}

@synthesize imageView,cameraSelectionBool,picker;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self GesturesRecognizer];
    [self hidden];
    [self toolBar];
    
    cameraSelectionBool= NO;
    picker =[[UIImagePickerController alloc]init];
    picker.delegate = self;

}

-(void) toolBar
{
    UIBarButtonItem *btnRed = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleDone target:self action:@selector(btnShareTouched)];
    UIBarButtonItem *btnBlue = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(btnFinalTouched)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *btnGreen = [[UIBarButtonItem alloc] initWithTitle:@"Background" style:UIBarButtonItemStyleDone target:self action:@selector(btnSetTouched)];
    self.toolbarItems = [NSArray arrayWithObjects:btnRed, spacer ,btnBlue, spacer, btnGreen, nil];
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0,20, self.view.frame.size.width, 44);
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    [self.view addSubview:toolbar];
    [toolbar setItems:self.toolbarItems];
}

-(void) hidden
{
    self.imageView.image = nil;
    self.imageViewTwo.image = nil;
    self.imageViewThree.image = nil;
    self.imageViewFour.image = nil;
    self.settingView.hidden = YES;
}

-(void) GesturesRecognizer
{
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetected:)];
    UIRotationGestureRecognizer *rotationRecognizerTwo = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetectedTwo:)];
    UIRotationGestureRecognizer *rotationRecognizerThree = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetectedThree:)];
    UIRotationGestureRecognizer *rotationRecognizerFour = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationDetectedFour:)];
    
    [self.imageView addGestureRecognizer:rotationRecognizer];
    [self.imageViewTwo addGestureRecognizer:rotationRecognizerTwo];
    [self.imageViewThree addGestureRecognizer:rotationRecognizerThree];
    [self.imageViewFour addGestureRecognizer:rotationRecognizerFour];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    UITapGestureRecognizer *tapRecognizerTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedTwo:)];
    UITapGestureRecognizer *tapRecognizerThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedThree:)];
    UITapGestureRecognizer *tapRecognizerFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedFour:)];
    
    tapRecognizer.numberOfTapsRequired = 2;
    tapRecognizerTwo.numberOfTapsRequired = 2;
    tapRecognizerThree.numberOfTapsRequired = 2;
    tapRecognizerFour.numberOfTapsRequired = 2;
    
    [self.imageView addGestureRecognizer:tapRecognizer];
    [self.imageViewTwo addGestureRecognizer:tapRecognizerTwo];
    [self.imageViewThree addGestureRecognizer:tapRecognizerThree];
    [self.imageViewFour addGestureRecognizer:tapRecognizerFour];
}

-(void)btnFinalTouched
{
    self.settingView.hidden = YES;
    cameraSelectionBool= NO;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Select Image" delegate:(id<UIActionSheetDelegate>)self cancelButtonTitle:@"Cancel"               destructiveButtonTitle:nil otherButtonTitles:@"Image From Camera",@"Image From Library",nil];
    
    [actionSheet showInView:self.view];
}

-(void)btnSetTouched
{
    self.settingView.hidden = NO;
}

-(void)btnShareTouched
{
    if (self.settingView.hidden == YES)
    {
            [self makeImage];
    }
    else
    {
        self.settingView.hidden = YES;
        [self makeImage];
    }
    
    [self performSelector:@selector(showShareScreen) withObject:Nil afterDelay:0.1f];
}

-(void)showShareScreen
{
    ShareViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"myViewControllersID"];
    controller.finalShareImage = viewImage;
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)customBackgroundAction:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Select Image" delegate:(id<UIActionSheetDelegate>)self cancelButtonTitle:@"Cancel"               destructiveButtonTitle:nil otherButtonTitles:@"Image From Camera",@"Image From Library",nil];
    [actionSheet showInView:self.view];
    cameraSelectionBool = YES;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [UIImagePickerController  availableMediaTypesForSourceType:picker.sourceType];
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:Nil];
    }
    else if (buttonIndex == 0)
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:Nil];
    }
    self.imageSelected.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (cameraSelectionBool)
    {
        self.cameraBackgroundImageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
        self.settingBackgroundImageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
   
    else if (!cameraSelectionBool)
    {
        if (self.imageView.image == nil)
        {
            self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        else if (self.imageViewTwo.image == nil)
        {
            self.imageViewTwo.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        else if (self.imageViewThree.image == nil)
        {
            self.imageViewThree.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        else if (self.imageViewFour.image == nil)
        {
            self.imageViewFour.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonAction:(id)sender
{
    UIImage *images = [sender backgroundImageForState:UIControlStateNormal];
    self.settingBackgroundImageView.image = images;
    self.cameraBackgroundImageView.image = images;
}

- (IBAction)CancelButtonCLick:(id)sender
{
    self.settingView.hidden = YES;
    cameraSelectionBool= NO;
 
}
- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


-(UIImage*) makeImage
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *sourceImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //now we will position the image, X/Y away from top left corner to get the portion we want
    UIGraphicsBeginImageContext(self.view.frame.size);
    [sourceImage drawAtPoint:CGPointMake(0, -50)];
    viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage,nil, nil, nil);
    
    self.imageShare = viewImage;
    return viewImage;
}

#pragma mark - Pan Gesture Recognizers

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
    
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor), recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            finalPoint.y = MIN(MAX(finalPoint.y, 100), self.view.bounds.size.height);
        } else
        {
            finalPoint.y = MIN(MAX(finalPoint.y, 170), self.view.bounds.size.height);
        }
    
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
        } completion:nil];
 }
    
}

#pragma mark - Rotation Gesture Recognizers

- (void)rotationDetected:(UIRotationGestureRecognizer *)rotationRecognizer
{
    CGFloat angle = rotationRecognizer.rotation;
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, angle);

    rotationRecognizer.rotation = 0.0;
}

- (void)rotationDetectedTwo:(UIRotationGestureRecognizer *)rotationRecognizer
{
    CGFloat angle2 = rotationRecognizer.rotation;
    self.imageViewTwo.transform = CGAffineTransformRotate(self.imageViewTwo.transform, angle2);
    rotationRecognizer.rotation = 0.0;
}

- (void)rotationDetectedThree:(UIRotationGestureRecognizer *)rotationRecognizer
{
    CGFloat angle3 = rotationRecognizer.rotation;
    self.imageViewThree.transform = CGAffineTransformRotate(self.imageViewThree.transform, angle3);
    rotationRecognizer.rotation = 0.0;
}

- (void)rotationDetectedFour:(UIRotationGestureRecognizer *)rotationRecognizer
{
    CGFloat angle4 = rotationRecognizer.rotation;
    self.imageViewFour.transform = CGAffineTransformRotate(self.imageViewFour.transform, angle4);
    rotationRecognizer.rotation = 0.0;
}

#pragma mark - Tap Gesture Recognizers

- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.image = nil;

    }];
}
- (void)tapDetectedTwo:(UITapGestureRecognizer *)tapRecognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        self.imageViewTwo.image = nil;
 
    }];
}

- (void)tapDetectedThree:(UITapGestureRecognizer *)tapRecognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        self.imageViewThree.image = nil;

    }];
}

- (void)tapDetectedFour:(UITapGestureRecognizer *)tapRecognizer
{
    [UIView animateWithDuration:0.25 animations:^{
        self.imageViewFour.image = nil;

    }];
}

#pragma mark - Pinch Gesture Recognizers

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    float imageScale = sqrtf(recognizer.view.transform.a * recognizer.view.transform.a + recognizer.view.transform.c * recognizer.view.transform.c);
    
    if ((recognizer.scale > 1.0) && (imageScale >= 2.0))
    {
        return;
    }
    if ((recognizer.scale < 1.0) && (imageScale <= 0.75))
    {
        return;
    }
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end
