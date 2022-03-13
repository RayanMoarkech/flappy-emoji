//
//  iPadGame.m
//  Flappy Emo
//
//  Created by Rayan on 9/12/14.
//  Copyright (c) 2014 Rayan Moarkech. All rights reserved.
//

#import "iPadGame.h"

@interface iPadGame ()

@end

@implementation iPadGame

-(void)Falling{
    
    [TunnelMovement invalidate];
    [BirdMovement invalidate];
    
    BirdMovFalling = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(BirdFalling) userInfo:nil repeats:YES];
    
    Bird.image = [UIImage imageNamed:@"EmojiDead.png"];
    
    GameOverTime = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(GameOver) userInfo:nil repeats:NO];
    
}

-(void)FallingFast{
    
    [TunnelMovement invalidate];
    [BirdMovement invalidate];
    
    BirdMovFalling = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(BirdFallingFromTop) userInfo:nil repeats:YES];
    
    Bird.image = [UIImage imageNamed:@"EmojiDead.png"];
    
    GameOverTime = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(GameOver) userInfo:nil repeats:NO];
    
}


-(void)GameOver{
    
    if (ScoreNumber > HighScoreNumber){
        [[NSUserDefaults standardUserDefaults] setInteger:ScoreNumber forKey:@"HighScoreSavedAll"];
    }
    
    if (ScoreNumber > HighScoreNumberNormal){
        [[NSUserDefaults standardUserDefaults] setInteger:ScoreNumber forKey:@"HighScoreSavedNormal"];
    }
    
    [TunnelMovement invalidate];
    [BirdMovement invalidate];
    
    Exit.hidden = NO;
    Back.hidden = NO;
    GameOver.hidden = NO;
    Retry.hidden = NO;
    DeadBird.hidden = NO;
    
    GameAdBanner.hidden = NO;
    
    TunnelTop.hidden = YES;
    TunnelBottom.hidden = YES;
    Bird.hidden = YES;
    Top.hidden = YES;
    Bottom.hidden = YES;
    
    ZeroScore.hidden = NO;
    if (ScoreNumber > 0){
        ZeroScore.hidden = YES;
    }
    
    DeadBird.center = CGPointMake(64, 995);
    
    if (ScoreNumber < 5){
        GameOver.hidden = NO;
        Nice.hidden = YES;
        GoodJob.hidden = YES;
        Great.hidden = YES;
        Excellent.hidden = YES;
    }
    
    if (ScoreNumber > 5){
        GameOver.hidden = NO;
        Nice.hidden = NO;
        GoodJob.hidden = YES;
        Great.hidden = YES;
        Excellent.hidden = YES;
    }
    
    if (ScoreNumber > 10){
        GameOver.hidden = NO;
        Nice.hidden = YES;
        GoodJob.hidden = NO;
        Great.hidden = YES;
        Excellent.hidden = YES;
    }
    
    if (ScoreNumber > 30){
        GameOver.hidden = NO;
        Nice.hidden = YES;
        GoodJob.hidden = YES;
        Great.hidden = NO;
        Excellent.hidden = YES;
    }
    
    if (ScoreNumber > 50){
        GameOver.hidden = NO;
        Nice.hidden = YES;
        GoodJob.hidden = YES;
        Great.hidden = YES;
        Excellent.hidden = NO;
    }
}


-(void)Score{
    
    ScoreNumber = ScoreNumber + 1;
    ScoreLabel.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    
}


-(IBAction)StartGame:(id)sender{
    
    TunnelTop.hidden = NO;
    TunnelBottom.hidden = NO;
    Bottom.hidden = NO;
    Top.hidden = NO;
    
    ScoreLabel.hidden = NO;
    ZeroScore.hidden = NO;
    
    DeadBird.hidden = YES;
    StartGame.hidden = YES;
    GameAdBanner.hidden =YES;
    
    BirdMovement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(BirdMoving) userInfo:nil repeats:YES];
    
    [self PlaceTunnels];
    
    TunnelMovement = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector (TunnelMoving) userInfo:nil repeats:YES];
    
    [StartGameButton play];
    [ButtonSound play];
    
}

-(IBAction)Retry:(id)sender{
    
    Bird.hidden = NO;
    StartGame.hidden = NO;
    
    DeadBird.hidden = YES;
    
    ScoreNumber = 0;
    
    ScoreLabel.hidden = NO;
    ScoreLabel.text = 0;
    
    Bird.center = CGPointMake(64, 484);
    
    [self viewDidLoad];
    
}



-(void)PlaceTunnels{
    
    RandomTopTunnelPosition = arc4random() %350;
    RandomTopTunnelPosition = RandomTopTunnelPosition - 228;
    RandomBottomTunnelPosition = RandomTopTunnelPosition + 1145;
    
    TunnelTop.center = CGPointMake(750, RandomTopTunnelPosition);
    TunnelBottom.center = CGPointMake(750, RandomBottomTunnelPosition);
    
}

-(void)TunnelMoving{
    
    TunnelTop.center = CGPointMake(TunnelTop.center.x - 2, TunnelTop.center.y);
    TunnelBottom.center = CGPointMake(TunnelBottom.center.x - 2, TunnelBottom.center.y);
    
    if (TunnelTop.center.x < -30) {
        [self PlaceTunnels];
    }
    
    
    if (CGRectIntersectsRect(Bird.frame, TunnelTop.frame)){
        [self Falling];
        [LostSound play];
        
    }
    
    if (CGRectIntersectsRect(Bird.frame, TunnelBottom.frame)){
        [self Falling];
        [LostSound play];
        
    }
    
    if (CGRectIntersectsRect(Bird.frame, Bottom.frame)){
        [self GameOver];
        [LostSound play];
    }
    
    if (CGRectIntersectsRect(Bird.frame, Top.frame)){
        [self FallingFast];
        [LostSound play];
    }
    
    if (ScoreNumber > 19){
        [self TunnelMoving1];
    }
    
    if (TunnelTop.center.x == 8){
        [self Score];
        [WinScore play];
        ZeroScore.hidden = YES;
    }
    
}

-(void)TunnelMoving1{
    
    TunnelTop.center = CGPointMake(TunnelTop.center.x - 1, TunnelTop.center.y);
    TunnelBottom.center = CGPointMake(TunnelBottom.center.x - 1, TunnelBottom.center.y);
    
    
    if (TunnelTop.center.x == 9){
        [self Score];
        [WinScore play];
        ZeroScore.hidden = YES;
        
    }
}


-(void)BirdMoving{
    
    Bird.center = CGPointMake(Bird.center.x, Bird.center.y - BirdFlight);
    
    BirdFlight = BirdFlight - 5;
    
    if (BirdFlight < -8) {
        BirdFlight = -13;
    }
    
    if (BirdFlight > 0) {
        Bird.image = [UIImage imageNamed:@"EmojiUp.png"];
    }
    
    if (BirdFlight < 0) {
        Bird.image = [UIImage imageNamed:@"EmojiDown.png"];
    }
    
    if (ScoreNumber > 19)
     if   (BirdFlight < -7){
        BirdFlight = -16;
    }
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    BirdFlight = 29;
    
}


-(void)BirdFalling{
    
    Bird.center = CGPointMake(Bird.center.x, Bird.center.y - BirdFall);
    
    BirdFall = -17;
}

-(void)BirdFallingFromTop{
    
    Bird.center = CGPointMake(Bird.center.x, Bird.center.y - BirdFall);
    
    BirdFall = -25;
}


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
    [GameOverTime invalidate];
    [BirdMovFalling invalidate];
    
    TunnelTop.hidden = YES;
    TunnelBottom.hidden = YES;
    Bottom.hidden = YES;
    Top.hidden = YES;
    DeadBird.hidden = YES;
    ZeroScore.hidden = YES;
    Retry.hidden = YES;
    Exit.hidden = YES;
    Back.hidden = YES;
    
    Bird.image = [UIImage imageNamed:@"EmojiUp.png"];
    Bird.center = CGPointMake(64, 484);
    ScoreNumber = 0;
    
    Bird.hidden = NO;
    StartGame.hidden = NO;
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSavedAll"];
    HighScoreNumberNormal = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSavedNormal"];
    
    ScoreLabel.hidden = YES;
    GameOver.hidden = YES;
    Nice.hidden = YES;
    GoodJob.hidden = YES;
    Great.hidden = YES;
    Excellent.hidden = YES;
    
    GameAdBanner.hidden = NO;
    

    // Make self the delegate of the ad banner.
    self.adBanner.delegate = self;
    
    // Initially hide the ad banner.
    self.adBanner.alpha = 0.0;
    
    
    
    [super viewDidLoad];
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/ButtonClickSound.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    ButtonSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    
    [super viewDidLoad];
    // Construct URL to sound file
    NSString *path1 = [NSString stringWithFormat:@"%@/WinScore.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl1 = [NSURL fileURLWithPath:path1];
    
    // Create audio player object and initialize with URL to sound
    WinScore = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl1 error:nil];
    
    
    [super viewDidLoad];
    // Construct URL to sound file
    NSString *path2 = [NSString stringWithFormat:@"%@/StartWistle.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    
    // Create audio player object and initialize with URL to sound
    StartGameButton = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
    
    
    [super viewDidLoad];
    // Construct URL to sound file
    NSString *path3 = [NSString stringWithFormat:@"%@/LostSound.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl3 = [NSURL fileURLWithPath:path3];
    
    // Create audio player object and initialize with URL to sound
    LostSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl3 error:nil];
    
    
    
    
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
