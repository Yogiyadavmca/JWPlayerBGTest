//
//  FirstVC.h
//  BasicPlayer-ObjC
//
//  Created by Yogesh Singh on 18/09/23.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface CustomModel : NSObject
@property (nonatomic, strong) NSString *contentUrl;
@property (nonatomic, strong) NSString *imageUrl;
@end

@implementation CustomModel
@end

@interface FirstVC : UIViewController<AVAudioPlayerDelegate>
@property (nonatomic, weak) IBOutlet UIView *contentView;
@property (nonatomic, strong) NSMutableArray<CustomModel *> *dataSource;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@end

NS_ASSUME_NONNULL_END
