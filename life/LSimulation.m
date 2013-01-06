//
//  LSimulation.m
//  life
//
//  Created by Kemal Enver on 15/10/2012.
//  Copyright (c) 2012 Kemal Enver. All rights reserved.
//

#import "LSimulation.h"

@implementation LSimulation

- (id) init {
    
    if(self = [super init]) {
        
        _size = CGSizeMake(gridW, gridH);
        _universe = [self createArray];
                
        for(int y=0; y < _size.height; y++) {
            
            for(int x=0; x<_size.width; x++) {
                
                _universe[y][x] = arc4random_uniform(100) < 10;
            }
        }
    }
    
    return self;
}

- (void) reset {
    
    for(int y = 0; y < _size.height; y++) {
        
        for(int x = 0; x < _size.width; x++) {
            
            //free((bool*)_universe[y][x]);
            _universe[y][x] = arc4random_uniform(100) < 8;
        }
    }
}

- (void) makeSpaceShip {
    
    for(int y = 0; y < _size.height; y++) {
        
        for(int x = 0; x < _size.width; x++) {
            
            _universe[y][x] = false;
        }
    }
    
    int rand = arc4random_uniform(100);

    if(arc4random_uniform(2) < 1) {
        
        _universe[1][2+rand] = true;
        _universe[2][2+rand] = true;
        _universe[3][2+rand] = true;
        
        _universe[3][1+rand] = true;
        _universe[2][0+rand] = true;
    }
    else {
        
        _universe[1][1+rand] = true;
        _universe[1][4+rand] = true;
        _universe[2][5+rand] = true;
        _universe[3][5+rand] = true;
        _universe[4][2+rand] = true;
        
        _universe[4][3+rand] = true;
        _universe[4][4+rand] = true;
        _universe[4][5+rand] = true;
    }
}

- (void) makePuffer {
    
    for(int y=0; y<_size.height; y++) {
        
        for(int x=0; x<_size.width; x++) {
            
            _universe[y][x] = false;
        }
    }
    
    _universe[40][41] = true;
    _universe[40][42] = true;
    _universe[40][43] = true;
    _universe[40][44] = true;
    _universe[40][45] = true;
    _universe[40][46] = true;
    _universe[40][47] = true;
    _universe[40][48] = true;
    
    _universe[40][50] = true;
    _universe[40][51] = true;
    _universe[40][52] = true;
    _universe[40][53] = true;
    _universe[40][54] = true;
    
    _universe[40][58] = true;
    _universe[40][59] = true;
    _universe[40][60] = true;
    
    _universe[40][67] = true;
    _universe[40][68] = true;
    _universe[40][69] = true;
    _universe[40][70] = true;
    _universe[40][71] = true;
    _universe[40][72] = true;
    _universe[40][73] = true;
    
    _universe[40][75] = true;
    _universe[40][76] = true;
    _universe[40][77] = true;
    _universe[40][78] = true;
    _universe[40][79] = true;
}

- (bool **) createArray {
    
    bool **array;
    
    if (( array = ( bool** )malloc( (_size.height+1)*sizeof( bool* ))) == NULL ) {
        
        assert(@"oh oh, how did that happen");
    }
    
    for ( int y = 0; y < _size.height; y++ ) {
        
        if (( array[y] = ( bool* )malloc( _size.width+1 )) == NULL ) {
            
            assert(@"oh oh, that's weird");
        }
        // Init it otherwise we'll access some dodgy memory!
        for(int x = 0; x < _size.width; x++) {
            
            array[y][x] = false;
        }
    }
    
    return array;
}

- (void) tick: (id) sender {
    
    bool **_tempUniverse = [self createArray];
    
    for(int y = 0; y < _size.height; y++) {
        
        for(int x = 0; x < _size.width; x++) {
            
            free((bool*)_tempUniverse[y][x]);
            
            int n = 0;
            for (int y1 = y - 1; y1 <= y + 1; y1++) {
                
                for (int x1 = x - 1; x1 <= x + 1; x1++) {
                    
                    if (_universe[(y1 + (int)_size.height) % (int)_size.height][(x1 + (int)_size.width) % (int)_size.width]) {
                        
                        n++;
                    }
                }
            }
            
            if (_universe[y][x]) {
                
                n--;
            }
            
            _tempUniverse[y][x] = (n == 3 || (n == 2 && _universe[y][x])); 
        }
    }
    
    free(_universe);
    
    _universe = _tempUniverse;
}

- (bool **) universe {
    
    return _universe;
}

- (NSString *) description {
    
    NSMutableString *gridString = [NSMutableString stringWithString: @"\n"];
    
    for(int y = 0; y < _size.height; y++) {
        
        for (int x = 0; x < _size.width; x++) {
            
            BOOL alive = _universe[y][x];
            
            [gridString appendString: alive ? @"+" : @"-"];
        }
        
        [gridString appendString: @"\n"];  
    }
    
    return gridString;
}

@end
