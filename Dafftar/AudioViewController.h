//
//  AudioViewController.h
//  Dafftar
//
//  Created by apple on 03/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface AudioViewController : UIViewController<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@property (weak, nonatomic) IBOutlet UIButton *recordPauseButton;

@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;


- (IBAction)recordPausedTapped:(id)sender;
- (IBAction)stopTapped:(id)sender;
- (IBAction)playTapped:(id)sender;


@end
