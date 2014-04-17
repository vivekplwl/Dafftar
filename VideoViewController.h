//
//  VideoViewController.h
//  Dafftar
//
//  Created by apple on 03/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface VideoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSString *savedVideoPath;
    NSString    *  mmm;
    
}
@property (copy,   nonatomic) NSURL *movieURL;
@property (strong, nonatomic) MPMoviePlayerController *movieController;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;



- (IBAction)TakeVideo:(id)sender;


@end
