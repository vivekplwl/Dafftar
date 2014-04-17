//
//  CameraViewController.h
//  Dafftar
//
//  Created by apple on 03/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
}



@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
- (IBAction)Capture:(id)sender;
- (IBAction)Liberary:(id)sender;

@end
