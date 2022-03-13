//
//  ViewController.m
//  Flappy Emo
//
//  Created by Rayan on 9/12/14.
//  Copyright (c) 2014 Rayan Moarkech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)StartSoundButton:(id)sender{
    
    [ButtonSound play];
}


- (void)viewDidLoad
{
    
    // Make self the delegate of the ad banner.
    self.adBanner.delegate = self;
    
    // Initially hide the ad banner.
    self.adBanner.alpha = 0.0;
    
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSavedAll"];
    HighScore.text = [NSString stringWithFormat:@"Best Score: %li", (long)HighScoreNumber];
    
    
    [super viewDidLoad];
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/ButtonClickSound.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
        
    // Create audio player object and initialize with URL to sound
    ButtonSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];

    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AdBannerViewDelegate method implementation

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 1.0;
    }];
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"Ad Banner action is about to begin.");
    
    return YES;
}


-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad Banner action did finish");
    
    
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.adBanner.alpha = 0.0;
    }];
}



@end
