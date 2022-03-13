//
//  Game.m
//  Flappy Emo
//
//  Created by Rayan on 9/12/14.
//  Copyright (c) 2014 Rayan Moarkech. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

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
    
    GameAD.hidden = NO;
    
    TunnelTop.hidden = YES;
    TunnelBottom.hidden = YES;
    Bird.hidden = YES;
    Top.hidden = YES;
    Bottom.hidden = YES;
    
    ZeroScore.hidden = NO;
    if (ScoreNumber > 0){
        ZeroScore.hidden = YES;
    }
    
    DeadBird.center = CGPointMake(40, 544);
    
    
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
    GameAD.hidden = YES;
    
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
    
    Bird.center = CGPointMake(40, 285);
    
    [self viewDidLoad];

}


-(void)PlaceTunnels{
    
    RandomTopTunnelPosition = arc4random() %350;
    RandomTopTunnelPosition = RandomTopTunnelPosition - 228;
    RandomBottomTunnelPosition = RandomTopTunnelPosition + 655;
    
    TunnelTop.center = CGPointMake(340, RandomTopTunnelPosition);
    TunnelBottom.center = CGPointMake(340, RandomBottomTunnelPosition);
    
}

-(void)TunnelMoving{
    
    TunnelTop.center = CGPointMake(TunnelTop.center.x - 1, TunnelTop.center.y);
    TunnelBottom.center = CGPointMake(TunnelBottom.center.x - 1, TunnelBottom.center.y);
    
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
    
    TunnelTop.center = CGPointMake(TunnelTop.center.x - 0.5, TunnelTop.center.y);
    TunnelBottom.center = CGPointMake(TunnelBottom.center.x - 0.5, TunnelBottom.center.y);
    
    if (TunnelTop.center.x == 10){
        [self Score];
        [WinScore play];
        ZeroScore.hidden = YES;
    }
}


-(void)BirdMoving{
    
    Bird.center = CGPointMake(Bird.center.x, Bird.center.y - BirdFlight);
    
    BirdFlight = BirdFlight - 5;
    
    if (BirdFlight < -8) {
        BirdFlight = -12;
    }
    
    if (BirdFlight > 0) {
        Bird.image = [UIImage imageNamed:@"EmojiUp.png"];
    }
    
    if (BirdFlight < 0) {
        Bird.image = [UIImage imageNamed:@"EmojiDown.png"];
    }
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    BirdFlight = 25;
    
}



-(void)BirdFalling{
    
    Bird.center = CGPointMake(Bird.center.x, Bird.center.y - BirdFall);
    
    BirdFall = -8;
}

-(void)BirdFallingFromTop{
    
    Bird.center = CGPointMake(Bird.center.x, Bird.center.y - BirdFall);
    
    BirdFall = -13;
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
    Bird.center = CGPointMake(40, 285);
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
        
        GameAD.hidden = NO;
    
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark iAD Delegate Methods

-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [banner setAlpha:1];
    
    [UIView commitAnimations];
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:1];
    
    [banner setAlpha:0];
    
    [UIView commitAnimations];
    
}


@end
