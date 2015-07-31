//
//  ViewController.h
//  TempoDemo
//
//  Created by 鲁辰 on 7/30/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Spotify/Spotify.h>
#import <CoreMotion/CoreMotion.h>

#define kUpdateFrequency	60.0

@interface ViewController : UIViewController<UIAccelerometerDelegate, SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate>

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (nonatomic, strong) NSMutableArray *date_array;
@property (nonatomic, strong) NSDate *lastDate;



@end

