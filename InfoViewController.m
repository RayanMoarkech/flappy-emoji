//
//  InfoViewController.m
//  Flappy Emo
//
//  Created by Rayan on 9/12/14.
//  Copyright (c) 2014 Rayan Moarkech. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

-(IBAction)SoundButton:(id)sender{
    
    [ButtonSound play];
}


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
    // Make self the delegate of the ad banner.
    self.adBanner.delegate = self;
    
    // Initially hide the ad banner.
    self.adBanner.alpha = 0.0;
    
    [super viewDidLoad];
    // Construct URL to sound file
    NSString *path= [NSString stringWithFormat:@"%@/ButtonClickSound.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    ButtonSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];

    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
