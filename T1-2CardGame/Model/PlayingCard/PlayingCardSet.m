//
//  PlayingCardSet.m
//  T1-2CardGame
//
//  Created by User on 23/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "PlayingCardSet.h"
#import "Content.h"

@implementation PlayingCardSet


+ (NSArray *)rankStrings{
    return @[@"?",@"1",@"2",@"3"];
}

+ (NSUInteger) maxRank {
    
    return [[self rankStrings] count] -1;
}

- (NSAttributedString *) contents{ // override the getter method of Card
    
    /*
    
    NSArray *rankStrings = [PlayingCardSet rankStrings];
    
    NSString * content = [[NSString alloc] initWithString: [rankStrings[self.rank] stringByAppendingString:self.shape]];
    
    content = [content stringByAppendingString:self.color];
    content = [content stringByAppendingString:self.shading];
    
    NSAttributedString * content2 = [[NSAttributedString alloc] initWithString:content];
     */
    
    
    return [Content titleForCardSet:self withBackSlash:@""];
}

-(int)match:(NSArray *)othercards{
    PlayingCardSet *secondCard = [othercards objectAtIndex:1];
    PlayingCardSet *thirdCard = [othercards objectAtIndex:2];
    
    if([self matchShapeFirst:self second:secondCard third:thirdCard]){
        
        if([self matchShadingFirst:self second:secondCard third:thirdCard]){
            
            if([self matchColorFirst:self second:secondCard third:thirdCard]){
                
                if([self matchRankFirst:self second:secondCard third:thirdCard]){
                    
                    return 1;
                }
            }
        }
    }
    
    
    return 0;
}

- (BOOL)matchShapeFirst:(PlayingCardSet *)first second:(PlayingCardSet *)second third:(PlayingCardSet *)third{
    
    if([first.shape isEqualToString:second.shape] && [first.shape isEqualToString:third.shape] && [second.shape isEqualToString:third.shape]){
        return true;
    }
    
    if(![first.shape isEqualToString:second.shape] && ![first.shape isEqualToString:third.shape] && ![second.shape isEqualToString:third.shape]){
        return true;
    }
    return false;
}

- (BOOL)matchShadingFirst:(PlayingCardSet *)first second:(PlayingCardSet *)second third:(PlayingCardSet *)third{
    
    if([first.shading isEqualToString:second.shading] && [first.shading isEqualToString:third.shading] && [second.shading isEqualToString:third.shading]){
        return true;
    }
    
    if(![first.shading isEqualToString:second.shading] && ![first.shading isEqualToString:third.shading] && ![second.shading isEqualToString:third.shading]){
        return true;
    }
    return false;
}

- (BOOL)matchColorFirst:(PlayingCardSet *)first second:(PlayingCardSet *)second third:(PlayingCardSet *)third{
    
    if([first.shape isEqual:second.shape] && [first.shape isEqual:third.shape] && [second.shape isEqual:third.shape]){
        return true;
    }
    
    if(![first.shape isEqual:second.shape] && ![first.shape isEqual:third.shape] && ![second.shape isEqual:third.shape]){
        return true;
    }
    
    return false;
}

- (BOOL)matchRankFirst:(PlayingCardSet *)first second:(PlayingCardSet *)second third:(PlayingCardSet *)third{
    
    if(first.rank == second.rank && first.rank == third.rank && second.rank == third.rank){
        return true;
    }
    
    if(!(first.rank == second.rank) && !(first.rank == third.rank) && !(second.rank == third.rank)){
        return true;
    }
    
    return false;
}


/*
+ (UITextView*)setShapeAndColor: (NSString*)string color:(UIColor *)color{
    NSDictionary *attrDict = @{ NSForegroundColorAttributeName : color };
    
    NSMutableAttributedString *AattrString = [[NSMutableAttributedString alloc] initWithString:string attributes: attrDict];

    UITextView *symbol = [UITextView new];
    [symbol setAttributedText:AattrString];
    
    [symbol setFont:[UIFont systemFontOfSize:40]];
    
    return symbol;
}
 */

/*
+ (NSArray *)validShape {

    UITextView *purpleCercle = [self setShapeAndColor:@"☻" color:[UIColor purpleColor]];
    UITextView *redCercle = [self setShapeAndColor:@"☻" color:[UIColor redColor]];
    UITextView *greenCercle = [self setShapeAndColor:@"☻" color:[UIColor greenColor]];
    
    UITextView *purpleTriangle = [self setShapeAndColor:@"▲" color:[UIColor purpleColor]];
    UITextView *redTriangle = [self setShapeAndColor:@"▲" color:[UIColor redColor]];
    UITextView *greenTriangle = [self setShapeAndColor:@"▲" color:[UIColor greenColor]];
    
    UITextView *purpleSquare = [self setShapeAndColor:@"■" color:[UIColor purpleColor]];
    UITextView *redSquare = [self setShapeAndColor:@"■" color:[UIColor redColor]];
    UITextView *greenSquare = [self setShapeAndColor:@"■" color:[UIColor greenColor]];
    
    return @[redCercle,purpleCercle,greenCercle, redTriangle,purpleTriangle,greenTriangle, redSquare,purpleSquare,greenSquare];

}
 */

+ (NSArray *)validShape {
    //□
    return @[@"●",@"▲",@"◼︎"];
    
}

+ (NSArray *)validColors{
    return @[@"green",@"purple",@"red"];
}


+ (NSArray *)validShades{
    return @[@"fill",@"blank",@"stripped"];
}



- (void)setShape:(NSString *)shape{
    if([[PlayingCardSet validShape] containsObject:shape]){
        _shape = shape;
    }
    
}


@end
