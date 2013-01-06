//
//  LGrid.m
//  life
//
//  Created by Kemal Enver on 15/10/2012.
//  Copyright (c) 2012 Kemal Enver. All rights reserved.
//

#import "LGrid.h"

@implementation LGrid

- (id) initWithDimensions: (CGSize) dimensions {
    
    if (self = [super init]) {

        self.frame = CGRectMake(2.0f, 2.0f, (gridW * squareSize) + 1.0f, (gridH * squareSize) + 1.0f);
        
        self.backgroundColor = RGB(254, 254, 194);
    }
    
    return self;
}

- (void) drawRect: (CGRect) rect {
    
    if(self.simulation) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [self drawSimulation: context];
        
        [RGB(193, 215, 179) setStroke];
        CGContextSetLineWidth(context, 1.0f);
        
        // Define line paths
        CGMutablePathRef verticalLine = CGPathCreateMutable();
        CGPathMoveToPoint(verticalLine, nil, 0.5f, 0.5f);
        CGPathAddLineToPoint(verticalLine, nil, 0.5f, rect.size.height+0.5f);
        
        CGMutablePathRef horizontalLine = CGPathCreateMutable();
        CGPathMoveToPoint(horizontalLine, nil, 0.5f, 0.5f);
        CGPathAddLineToPoint(horizontalLine, nil, rect.size.width+0.5f, 0.5f);
        
        CGContextSaveGState(context);
        for(int x = 0; x<=self.simulation.size.width+1; x++) {
            
            CGContextAddPath(context, verticalLine);
            CGContextTranslateCTM(context, squareSize, 0);
            CGContextDrawPath(context, kCGPathStroke);
        }
        CGContextRestoreGState(context);
        
        CGContextSaveGState(context);
        for(int y = 0; y<=self.simulation.size.height+1; y++) {
            
            CGContextAddPath(context, horizontalLine);
            CGContextTranslateCTM(context, 0, squareSize);
            CGContextDrawPath(context, kCGPathStroke);
        }
        CGContextRestoreGState(context);
        
        // Clean up paths
        CGPathRelease(verticalLine);
        CGPathRelease(horizontalLine);
    }
}

- (void) drawSimulation: (CGContextRef) context {
    
    [RGB(56, 65, 48) setFill];
    
    bool **universe = [self.simulation universe];
    
    for(int y = 0; y< self.simulation.size.height; y++) {
        
        for (int x = 0; x < self.simulation.size.width; x++) {
            
            BOOL alive = universe[y][x];
            
            // If the cell is alive fill it!
            if(alive) {
                
                CGContextFillRect(context, CGRectMake((x*squareSize)+0.5f, (y*squareSize)+0.5f, squareSize, squareSize));
            }
        }
    }
}

@end
