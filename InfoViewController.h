//
//  InfoViewController.h
//  Flappy Emo
//
//  Created by Rayan on 9/12/14.
//  Copyright (c) 2014 Rayan Moarkech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <iAd/iAd.h>

@interface InfoViewController : UIViewController <ADBannerViewDelegate>

{
    AVAudioPlayer *ButtonSound;
}

-(IBAction)SoundButton:(id)sender;

@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;

@end
