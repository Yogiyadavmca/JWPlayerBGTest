//
//  ViewController.h
//  BasicPlayer-ObjC
//
//  Created by Michael Salvador on 8/3/21.
//

#import <UIKit/UIKit.h>
#import <JWPlayerKit/JWPlayerKit.h>
#import "JWPlayerKit/JWPlayerObjCViewController.h"

@interface ViewController : JWPlayerObjCViewController<JWPlayerStateDelegate>
@property (nonatomic, weak) NSString *contentUrl;
@property (nonatomic, weak) NSString *imageUrl;

-(void)playContent:(NSString*)contentUrl imageUrl:(NSString*)imageUrl;
@end

