//
//  QRViewController.h
//  Dafftar
//
//  Created by apple on 03/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>


@interface QRViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    
}

@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;


@property (weak, nonatomic) IBOutlet UIButton *bbitemStart;


- (IBAction)StartStopReading:(id)sender;

@end
