//
//  LViewController.h
//  life
//
//  Created by Kemal Enver on 12/10/2012.
//  Copyright (c) 2012 Kemal Enver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LGrid.h"
#import "LSimulation.h"

@interface LViewController : UIViewController {
    
    LGrid *_grid;
    LSimulation *_simulation;
    
    UILabel *_infoLabel;
    int _generation;
    
    NSTimer *_ticker;
}

@property (nonatomic, readonly) LGrid *grid;

@end
