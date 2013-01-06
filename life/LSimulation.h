//
//  LSimulation.h
//  life
//
//  Created by Kemal Enver on 15/10/2012.
//  Copyright (c) 2012 Kemal Enver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSimulation : NSObject {
    
    CGSize _size;
    
    bool **_universe;
}

@property (nonatomic, readonly) CGSize size;

- (void) tick: (id) sender;

- (void) reset;

- (void) makeSpaceShip;

- (void) makePuffer;

- (bool **) universe;

@end
