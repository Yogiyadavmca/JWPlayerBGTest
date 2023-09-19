//
//  AppDelegate.m
//  JWPlayerBGTest
//
//  Created by Yogesh Singh on 19/09/23.
//

#import "AppDelegate.h"
#import <JWPlayerKit/JWPlayerKit.h>
@import AVFoundation;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [JWPlayerKitLicense setLicenseKey: @""];
    
    
    // Configure the audio session
    NSError *sessionError = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&sessionError];

    if (sessionError) {
        NSLog(@"Error setting audio session category: %@", sessionError.localizedDescription);
    }

    [audioSession setActive:YES error:&sessionError];

    if (sessionError) {
        NSLog(@"Error activating audio session: %@", sessionError.localizedDescription);
    }
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
