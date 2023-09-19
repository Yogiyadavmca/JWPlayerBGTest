//
//  FirstVC.m
//  BasicPlayer-ObjC
//
//  Created by Yogesh Singh on 18/09/23.
//

#import "FirstVC.h"
#import "ViewController.h"

#define videoUrlString @"https://playertest.longtailvideo.com/adaptive/oceans/oceans.m3u8"
#define posterUrlString @"https://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg"

@interface FirstVC ()
@property (nonatomic, assign) int counter;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CustomModel *model1 = [[CustomModel alloc] init];
    model1.contentUrl = @"https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3";
    model1.imageUrl = posterUrlString;

    CustomModel *model2 = [[CustomModel alloc] init];
    model2.contentUrl = @"https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav";
    model2.imageUrl = @"https://picsum.photos/seed/picsum/480/268";
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:model1, model2, nil];
    self.counter = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];
    
    [self initializeAudioPlayer];
}

- (IBAction)playButtonTapped:(id)sender {
    [self playNextClass];
}

-(void)playNextClass {
    NSLog(@"playNextClass");
    if (self.counter < self.dataSource.count) {
        CustomModel *data = [self.dataSource objectAtIndex: self.counter];
        [self playContent: data.contentUrl imageUrl:data.imageUrl];
    }
}

-(void)playContent:(NSString*)contentUrl imageUrl:(NSString*)imageUrl {
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self addChildViewController:vc];
    vc.view.frame = self.contentView.bounds;
    [self.contentView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
    [vc playContent:contentUrl imageUrl:imageUrl];
}

- (void)initializeAudioPlayer {
    // Audio file URL (replace with your own or a remote URL)
    NSURL *audioURL = [NSURL URLWithString:videoUrlString];
    
    // Initialize audio player
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&error];
    
    if (error) {
        NSLog(@"Error initializing audio player: %@", [error localizedDescription]);
        return;
    }
    
    // Set delegate
    self.audioPlayer.delegate = self;
    
    // Prepare to play
    [self.audioPlayer prepareToPlay];
}

- (void) removeObjects {
    NSLog(@"removeObjects");
    [[self.contentView subviews]
     makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    NSLog(@"playback completed");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"inside main");
        [self removeObjects];
        self.counter++;
        [self playNextClass];
    });
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
