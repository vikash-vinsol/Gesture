//
//  ShareViewController.h
//  GestureRecognizers
//
//  Created by Vikash Soni on 01/11/13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController
{
    
}

@property (nonatomic, weak) UIImage *finalShareImage;
- (IBAction)saveButton:(id)sender;
- (IBAction)emailButton:(id)sender;
- (IBAction)facebookButton:(id)sender;
- (IBAction)twitterButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
- (IBAction)airDropButton:(id)sender;


@end
