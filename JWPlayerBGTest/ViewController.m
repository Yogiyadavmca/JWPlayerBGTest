//
//  ViewController.m
//  BasicPlayer-ObjC
//
//  Created by Michael Salvador on 8/3/21.
//

#import "ViewController.h"
#import "AppDelegate.h"

#define videoUrlString @"https://playertest.longtailvideo.com/adaptive/oceans/oceans.m3u8"
#define posterUrlString @"https://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the view's background color to black for better contrast.
    self.view.backgroundColor = UIColor.blackColor;

    self.delegate = self;
    
    // Set up the player.
    //[self setUpPlayer];
}

-(void)playContent:(NSString*)contentUrl imageUrl:(NSString*)imageUrl {
    [self setUpPlayer:contentUrl imageUrl:imageUrl];
}

/**
 Sets up the player with a simple configuration.
 */
- (void)setUpPlayer:(NSString*)contentUrl imageUrl:(NSString*)imageUrl {
    NSURL *videoUrl = [NSURL URLWithString:contentUrl];
    NSURL *posterUrl = [NSURL URLWithString:imageUrl];

    NSLog(@"YKS: setUpPlayer contentUrl %@", contentUrl);
    NSLog(@"YKS: setUpPlayer posterUrl %@", posterUrl);
    self.enableLockScreenControls = YES;
    
    // First, use the JWPlayerItemBuilder to create a JWPlayerItem that will be used by the player configuration.
    JWError *playerItemError;
    JWPlayerItemBuilder *playerItemBuilder = [[JWPlayerItemBuilder alloc] init];
    [playerItemBuilder file:videoUrl];
    [playerItemBuilder posterImage:posterUrl];
    JWPlayerItem *playerItem = [playerItemBuilder buildAndReturnError:&playerItemError];
    if (playerItemError != nil) {
        // Handle error
        NSLog(@"YKS: setUpPlayer playerItemError %@", playerItemError);
        return;
    }

    // Second, create a player config with the created JWPlayerItem.
    JWError *configError;
    JWPlayerConfigurationBuilder *configBuilder = [[JWPlayerConfigurationBuilder alloc] init];
    [configBuilder autostart: YES];
    [configBuilder playlistWithItems:@[playerItem]];
    JWPlayerConfiguration *config = [configBuilder buildAndReturnError:&configError];
    if (configError != nil) {
        // Handle error
        NSLog(@"YKS: setUpPlayer error %@", configError);
        return;
    }

    // Lastly, use the created JWPlayerConfiguration to set up the player.
    [self.player configurePlayerWith:config];
    NSLog(@"YKS: setUpPlayer configurePlayerWith %@", config);
    NSLog(@"YKS: setUpPlayer isMain %@", [NSThread isMainThread] ? @"Yes" : @"No");
}

- (void)jwplayerContentWillComplete:(id <JWPlayer> _Nonnull)player {
    NSLog(@"YKS: jwplayerContentWillComplete =>");
}

- (void)jwplayerContentDidComplete:(id <JWPlayer> _Nonnull)player {
    NSLog(@"YKS: jwplayerContentDidComplete =>");
    [[NSNotificationCenter defaultCenter]
            postNotificationName:@"TestNotification"
            object:self];
}

- (void)playerViewController:(JWPlayerViewController *)controller sizeChangedFrom:(CGSize)oldSize to:(CGSize)newSize
{}

- (void)playerViewController:(JWPlayerViewController *)controller screenTappedAt:(CGPoint)position {
    NSLog(@"YKS: screenTappedAt =>");
}

- (void)playerViewController:(JWPlayerViewController *)controller controlBarVisibilityChanged:(BOOL)isVisible frame:(CGRect)frame {}

- (JWFullScreenViewController * _Nullable)playerViewControllerWillGoFullScreen:(JWPlayerViewController * _Nonnull)controller {
    NSLog(@"YKS: playerViewControllerWillGoFullScreen =>");
    return nil;
}

- (void)playerViewControllerDidGoFullScreen:(JWPlayerViewController *)controller {
    NSLog(@"YKS: playerViewControllerDidGoFullScreen =>");
}

- (void)playerViewControllerWillDismissFullScreen:(JWPlayerViewController *)controller {
    NSLog(@"YKS: playerViewControllerWillDismissFullScreen =>");
}

- (void)playerViewControllerDidDismissFullScreen:(JWPlayerViewController *)controller {
    NSLog(@"YKS: playerViewControllerDidDismissFullScreen =>");
}

- (void)playerViewController:(JWPlayerViewController *)controller relatedMenuClosedWithMethod:(enum JWRelatedInteraction)method {
    NSLog(@"YKS: relatedMenuClosedWithMethod =>");
}

- (void)playerViewController:(JWPlayerViewController *)controller relatedMenuOpenedWithItems:(NSArray<JWPlayerItem *> *)items withMethod:(enum JWRelatedInteraction)method
{
    NSLog(@"YKS: relatedMenuOpenedWithItems =>");
}

- (void)playerViewController:(JWPlayerViewController *)controller relatedItemBeganPlaying:(JWPlayerItem *)item atIndex:(NSInteger)index withMethod:(enum JWRelatedInteraction)method
{
    
}

- (void)jwplayer:(id <JWPlayer> _Nonnull)player didBecomeIdleWithReason:(enum JWIdleReason)reason {
    NSLog(@"YKS: didBecomeIdleWithReason => %ld", (long)reason);
}

- (void)jwplayer:(id <JWPlayer> _Nonnull)player failedWithError:(NSUInteger)code message:(NSString * _Nonnull)message {
    NSLog(@"YKS: failedWithError => %@", message);
}
@end
