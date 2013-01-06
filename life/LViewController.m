//
//  LViewController.m
//  life
//
//  Created by Kemal Enver on 12/10/2012.
//  Copyright (c) 2012 Kemal Enver. All rights reserved.
//

#import "LViewController.h"

@interface LViewController ()

@end

@implementation LViewController

- (void) loadView {
    
    [super loadView];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.wantsFullScreenLayout = YES;
    
    self.view.backgroundColor = RGB(56, 65, 48);
        
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    float temp = floorf(screenSize.height / squareSize);
    screenSize.height = floorf(screenSize.width / squareSize);
    screenSize.width =  temp;
    
    CGSize dimensions = screenSize;
    
    _grid = [[LGrid alloc] initWithDimensions: dimensions];
    
    CGRect frame = _grid.frame;
    frame.origin.y = floorf(([UIScreen mainScreen].bounds.size.width - frame.size.height) / 2.0f);
    frame.origin.x = floorf(([UIScreen mainScreen].bounds.size.height - frame.size.width) / 2.0f);
    _grid.frame = frame;
    
    [self.view addSubview: _grid];
    
    _infoLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, _grid.frame.size.height-20, _grid.frame.size.width, 20)];
    _infoLabel.backgroundColor = [UIColor clearColor];
    _infoLabel.font = [UIFont fontWithName: @"CourierNewPS-BoldMT" size: 14];
    _infoLabel.textColor = RGB(28, 32, 35);
    _infoLabel.textAlignment = NSTextAlignmentRight;
    _infoLabel.shadowColor = [UIColor whiteColor];
    _infoLabel.shadowOffset = CGSizeMake(1, 1);
    _infoLabel.text = @"1 tap: restart, 2 taps: glider, 3 taps: infinite pattern";
    
    [_grid addSubview: _infoLabel];
}

- (void) viewDidAppear:(BOOL)animated {
    
    _simulation = [[LSimulation alloc] init];
    
    self.grid.simulation = _simulation;
}

- (void) tick: (NSTimer *) timer {
    
    _generation++;
    _infoLabel.text = [NSString stringWithFormat: @"Generation %d", _generation];
    [_simulation tick: timer];
    [_grid setNeedsDisplay];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_ticker invalidate];
    _generation = 0;
    
    if(event.allTouches.count == 1) {
        
        [_simulation reset];
    }
    else if(event.allTouches.count == 2) {

        [_simulation makeSpaceShip];
        
    }
    else if(event.allTouches.count == 3) {
        
        [_simulation makePuffer];
    }
    
    _ticker = [NSTimer scheduledTimerWithTimeInterval: 0.15
                                               target: self
                                             selector: @selector(tick:)
                                             userInfo: nil
                                              repeats: YES];
    
}

@end
