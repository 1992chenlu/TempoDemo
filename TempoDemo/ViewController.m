//
//  ViewController.m
//  TempoDemo
//
//  Created by 鲁辰 on 7/30/15.
//  Copyright (c) 2015 ChenLu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 1.0 / kUpdateFrequency;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelerationData:accelerometerData.acceleration];
                                                 if(error){
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(run)
                                                   object:nil];
    [myThread start];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) outputAccelerationData:(CMAcceleration)acceleration
{
    //init lastDate
    if (self.lastDate == nil) {
        self.lastDate = [NSDate date];
        _date_array = [[NSMutableArray alloc] init];
        [_date_array addObject:self.lastDate];
        return;
    }
    
    NSDate *current = [NSDate date];
    NSTimeInterval secs = [_lastDate timeIntervalSinceDate:current];
    
    if (acceleration.y < -0.8 && fabs(secs) > 0.5) {
        [_date_array addObject:current];
        if ([_date_array count] > 20)
            [_date_array removeObjectAtIndex:0];
        
        _lastDate = current;
        
        NSLog(@"%f", secs);
        NSLog(@"%f", fabs(acceleration.y));
    }
}

-(double) getTempo{
    NSDate *start = [_date_array objectAtIndex:0];
    NSInteger endCount = [_date_array count];
    NSDate *end = [_date_array objectAtIndex:(endCount - 1)];
    NSTimeInterval secs = [start timeIntervalSinceDate:end];
    
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSinceDate:end];
    
    return interval > 3 ? (interval * fabs(secs) / endCount) : (fabs(secs) / endCount);
}

- (void)run {
    while (YES) {
        double tempo = 0.0;
        @synchronized(self) {
            tempo = [self getTempo];
        }
        NSThread *current = [NSThread currentThread];
        NSLog(@"Hahahahahahahah! Value: %f, Thread: %@", tempo, current);
        if (tempo < 0.7) {
            //fast
        } else if (tempo < 4) {
            //medium
        } else {
            //slow
        }
        sleep(1);
    }
}

@end
