//
//  ShareViewController.m
//  GestureRecognizers
//
//  Created by Vikash Soni on 01/11/13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

#import "ShareViewController.h"
#import <Social/Social.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface ShareViewController ()

@end

@implementation ShareViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender
{
    UIImage* image = self.finalShareImage;                     // produce your image
    NSData* imageData =  UIImagePNGRepresentation(image);     // get png representation
    UIImage* pngImage = [UIImage imageWithData:imageData];    // rewrap
    UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil);
    
    NSLog(@"saving image done");
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Saved" message:@"Image Saved To Your Library" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)emailButton:(id)sender
{
    MFMailComposeViewController *emailShareController = [[MFMailComposeViewController alloc] init];
    emailShareController.mailComposeDelegate = self;
    [emailShareController setSubject:@"Share Image"];
    [emailShareController setMessageBody:@"Vikas is sharing image...!!!" isHTML:NO];
    [emailShareController addAttachmentData:UIImageJPEGRepresentation(self.finalShareImage, 1) mimeType:@"image/jpeg" fileName:@"your_image.jpeg"];
    if (emailShareController) [self presentViewController:emailShareController animated:YES completion:nil];
}

- (IBAction)facebookButton:(id)sender
{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *FBSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [FBSheet setInitialText:@"Posting from my own app! :)"];
        
        if (self.finalShareImage)
        {
            [FBSheet addImage:self.finalShareImage];
        }
        [self presentViewController:FBSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure your device has an internet connection and you have Facebook account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (error)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:[NSString stringWithFormat:@"error %@",[error description]] delegate:nil cancelButtonTitle:@"dismiss" otherButtonTitles:nil, nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)twitterButton:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Tweeting from my own app! :)"];
        
        if (self.finalShareImage)
        {
            [tweetSheet addImage: self.finalShareImage];
        }
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)cancelButton:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)airDropButton:(id)sender
{
    NSArray *objectsToShare = @[self.finalShareImage];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    // Exclude all activities except AirDrop.
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage, UIActivityTypeMail,
                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
    controller.excludedActivityTypes = excludedActivities;
    
    // Present the controller
    [self presentViewController:controller animated:YES completion:nil];
}

@end
