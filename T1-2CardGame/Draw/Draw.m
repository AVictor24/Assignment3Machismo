//
//  Draw.m
//  BezzierPath
//
//  Created by User on 07/12/2017.
//  Copyright © 2017 X2 Mobile. All rights reserved.
//

#import "Draw.h"

@implementation Draw


#define  addheight  55.0

#define  addweight  55.0


-(UIBezierPath *)createBezzierPath{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(2 + addweight, 26 + addheight)];
    
    //Seg 1
    
    [path addLineToPoint:CGPointMake(2 +addweight, 15 + addheight)];
    
    //Seg 2 curve
    
    [path addCurveToPoint:CGPointMake(0 + addweight, 12 + addheight) controlPoint1:CGPointMake(2 + addweight, 14 + addheight) controlPoint2:CGPointMake(0 + addweight, 14 + addheight)];
    
    //Seg 3
    
    [path addLineToPoint:CGPointMake(0 + addweight, 2 + addheight)];
    
    //Seg 4 arc
    CGFloat startAngle =M_PI;
    CGFloat endAngle = 3 * M_PI_2;
    CGFloat zero = 0;
    
    [path addArcWithCenter: CGPointMake(2 + addweight, 2 + addheight)  //center point of circle
                    radius:2
                startAngle: startAngle  // π radians = 180 degrees = straight left
                  endAngle:endAngle  // 3π/2 radians = 270 degrees = straight up
                 clockwise:true];
    
    
    // Seg 5
    
    [path addLineToPoint:CGPointMake(8 + addweight , 0 + addheight)];
    
    // Seg6 arc
    
    [path addArcWithCenter:CGPointMake(8 + addweight , 2 + addheight)
                    radius:2
                startAngle:endAngle// straight up
                  endAngle:zero       // 0 radians = straight right
                 clockwise:true];
    
    
    // Seg7
    
    [path addLineToPoint:CGPointMake(10 + addweight , 12 + addheight )];
    
    // Seg8 curve
    
    [path addCurveToPoint:CGPointMake(8 + addweight, 15 + addheight) controlPoint1:CGPointMake(10 + addweight, 14 + addheight) controlPoint2:CGPointMake(8 + addweight, 14 + addheight)];
    
    // Seg9
    
    [path addLineToPoint:CGPointMake(8 + addweight, 26 + addheight )];
    
    
    [path closePath];
    
    return path;
}


- (UIBezierPath *)createOvalPath:(CGFloat) x y:(CGFloat)y{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    int sizewidth = self.bounds.size.width / 4;
    int sizeheigth = self.bounds.size.height / 8;
    
    
    /*
    
    [path moveToPoint:CGPointMake(x, y)];
    
    [path addLineToPoint:CGPointMake(x, 0)];
    
    [path addLineToPoint:CGPointMake(x, self.bounds.size.height)];
    */
    
    //////
    
    [path moveToPoint:CGPointMake(x - sizewidth/2, y + sizeheigth/2)];
    
    
    [path addQuadCurveToPoint:CGPointMake(x - sizewidth/2, y - sizeheigth/2) controlPoint:CGPointMake(x - 2*sizewidth, y)];
    
    [path addLineToPoint:CGPointMake(x + sizewidth/2, y - sizeheigth/2)];
    
    [path addQuadCurveToPoint:CGPointMake(x + sizewidth/2, y + sizeheigth/2) controlPoint:CGPointMake(x + 2*sizewidth, y)];
    
    [path addLineToPoint:CGPointMake(x - sizewidth/2, y + sizeheigth/2)];
    
    return path;
}

-(UIBezierPath *)createDiamondPath:(CGFloat) x y:(CGFloat) y{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    int sizewidth = self.bounds.size.width / 2;
    int sizeheight = self.bounds.size.height / 10;
    
    // x -= sizewidth / 2;
    
    /*
    [path moveToPoint:CGPointMake(x, y)];
    
    [path addLineToPoint:CGPointMake(x, 0)];
    
    [path addLineToPoint:CGPointMake(x, self.bounds.size.height)];
    */
    ////
    
    
    [path moveToPoint:CGPointMake(x, y)];
    
    [path moveToPoint:CGPointMake(x - sizewidth / 2, y )];
    
    [path addLineToPoint:CGPointMake(x , y - sizeheight)];
    
    [path addLineToPoint:CGPointMake(x + sizewidth / 2, y)];
    
    [path addLineToPoint:CGPointMake(x, y + sizeheight)];
    
    [path addLineToPoint:CGPointMake(x - sizewidth / 2, y)];
     
    
    return path;
}


-(UIBezierPath *)createSquigglePath: (CGFloat) x y:(CGFloat)y{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    int sizewidth = self.bounds.size.width / 2;
    int sizeheigth = self.bounds.size.height / 8;
    
    [path moveToPoint:CGPointMake(x, y - sizeheigth/2)];
    
    //2
    [path addQuadCurveToPoint:CGPointMake(x + sizewidth/2, y - sizeheigth/2) controlPoint:CGPointMake(x + sizewidth/4, y )];
    
    //3
    
    [path addQuadCurveToPoint:CGPointMake(x + sizewidth/2, y + sizeheigth/2) controlPoint:CGPointMake(x + sizewidth/2 + sizeheigth/2, y )];
    
    //4
    
    [path addQuadCurveToPoint:CGPointMake(x, y + sizeheigth/2) controlPoint:CGPointMake(x + sizewidth/4, y + sizeheigth)];
    
    //5
    
    [path addQuadCurveToPoint:CGPointMake(x - sizewidth/2, y + sizeheigth/2) controlPoint:CGPointMake(x - sizewidth/4, y)];
    
    //6
    
    [path addQuadCurveToPoint:CGPointMake(x - sizewidth/2, y - sizeheigth/2) controlPoint:CGPointMake(x - sizewidth/2 - sizeheigth/2, y)];
    
    //1
    
    [path addQuadCurveToPoint:CGPointMake(x, y - sizeheigth/2) controlPoint:CGPointMake(x - sizewidth/4, y - sizeheigth)];
    
    return path;
}


-(UIBezierPath *)drawShape:(NSString *)shape x:(int)x y:(int)y{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if([shape isEqualToString:@"oval"]){
        path = [self createOvalPath:x y:y];
    }
    else if([shape isEqualToString:@"squiggle"]){
        path = [self createSquigglePath:x y:y];
    }
    
    else if([shape isEqualToString:@"diamond"]){
        path = [self createDiamondPath:x y:y];
    }
    
    
    return path;
}


-(NSMutableArray *)goodDraw: (NSString *)shape rank:(NSUInteger)rank{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    NSMutableArray * paths = [[NSMutableArray alloc] init];
    
    int x = self.bounds.size.width / 2;  
    
    int y = self.bounds.size.height / 2;
    
    if(rank == 2){
        
        y = self.bounds.size.height / 2 - self.bounds.size.height/3 ;
        path = [self drawShape:shape x:x y:y];
        [paths addObject:path];
        
        y = self.bounds.size.height / 2 + self.bounds.size.height/3 ;
        path = [self drawShape:shape x:x y:y];
        [paths addObject:path];
    }
    else if(rank == 3){
        
        y = self.bounds.size.height / 2 - self.bounds.size.height/3 ;
        path = [self drawShape:shape x:x y:y];
        [paths addObject:path];
        
        y = self.bounds.size.height / 2 ;
        path = [self drawShape:shape x:x y:y];
        [paths addObject:path];
        
        y = self.bounds.size.height / 2 + self.bounds.size.height /3 ;
        path = [self drawShape:shape x:x y:y];
        [paths addObject:path];
        
    }
    else{
        
        path = [self drawShape:shape x:x y:y];
        [paths addObject:path];
    }
    
    return paths;
}

+ (NSDictionary *)shapeColors {
    return  @{@"red":[UIColor redColor], @"purple":[UIColor purpleColor], @"green":[UIColor greenColor]};
}

+ (NSDictionary *)shades {
    return  @{@"fill":@-10, @"blank":@8, @"stripped":@-10};
}

- (void)drawRect:(CGRect)rect {
    
    NSMutableArray * paths = [[NSMutableArray alloc] init];
    
    paths = [self goodDraw:self.shape rank:self.rank];
    
    for(UIBezierPath* path in paths){
        //fill
        if(![self.shading isEqualToString:@"stripped"]){
            UIColor* color = [[Draw shapeColors] objectForKey:self.color];
            [color setFill];
        }
        
        //stroke
        
        path.lineWidth = 1.0;
        //UIColor* strokeColor = [UIColor blackColor];
        UIColor* strokeColor = [[Draw shapeColors] objectForKey:self.color];
        [strokeColor setStroke];
        
        //Move the path to a new location
        
        //[path applyTransform:CGAffineTransformMakeTranslation(10, 10)];
        
        // fill and stroke the path (always last)
        
        if([self.shading isEqualToString:@"fill"]){
            [path fill];
        }
        else if([self.shading isEqualToString:@"stripped"]){
            
            
            [[UIColor whiteColor] set];             // green color for the outline
            [path fill];
            
            CGRect bounds = path.bounds;
            
            // create a UIBezierPath for the fill pattern
            UIBezierPath *stripes = [UIBezierPath bezierPath];
            
            int increment;
            
            /*
            if(self.bounds.size.width < 100){
                increment = 5;
            }
            else{
                increment =self.bounds.size.width/18;
            }
             */
            //increment = self.bounds.size.width/18;
             increment = 5;
            
            for ( int x = 0; x < bounds.size.width; x += increment)
            {
                [stripes moveToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y )];
                [stripes addLineToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y + bounds.size.height )];
            }
            [stripes setLineWidth:2];
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            // draw the fill pattern first, using the outline to clip
            UIColor* color = [[Draw shapeColors] objectForKey:self.color];
            
            CGContextSaveGState( context );         // save the graphics state
            [path addClip];                        // use the outline as the clipping path
            [color set];              //  color for vertical stripes
            [stripes stroke];                       // draw the stripes
            CGContextRestoreGState( context );      // restore the graphics state, removes the clipping path
            
            // draw the outline of the shape
            //[[UIColor blackColor] set];             // green color for the outline
            [color set];
            [path stroke];
            
            
        }
        
        [path stroke];
    }
}

@end
