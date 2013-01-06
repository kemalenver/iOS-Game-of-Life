//
//  LGrid.h
//  life
//
//  Created by Kemal Enver on 15/10/2012.
//  Copyright (c) 2012 Kemal Enver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSimulation.h"

@interface LGrid : UIView {
    
    __weak LSimulation *_simulation;
}

- (id) initWithDimensions: (CGSize) dimensions;
- (void) drawSimulation: (CGContextRef) context;

@property (weak) LSimulation *simulation;

@end
