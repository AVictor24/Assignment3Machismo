//
//  PlayingCardSetView.m
//  T1-2CardGame
//
//  Created by User on 14/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "PlayingCardSetView.h"
#import "CardMatchingGameView.h"
@implementation PlayingCardSetView


+ (NSArray *)rankStrings{
    return @[@"?",@"1",@"2",@"3"];
}

+ (NSUInteger) maxRank {
    
    return [[self rankStrings] count] -1;
}



-(int)match:(NSArray *)othercards{
    PlayingCardSetView *secondCard = [othercards objectAtIndex:1];
    PlayingCardSetView *thirdCard = [othercards objectAtIndex:2];
    
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

- (BOOL)matchShapeFirst:(PlayingCardSetView *)first second:(PlayingCardSetView *)second third:(PlayingCardSetView *)third{
    
    if([first.shape isEqualToString:second.shape] && [first.shape isEqualToString:third.shape] && [second.shape isEqualToString:third.shape]){
        return true;
    }
    
    if(![first.shape isEqualToString:second.shape] && ![first.shape isEqualToString:third.shape] && ![second.shape isEqualToString:third.shape]){
        return true;
    }
    return false;
}

- (BOOL)matchShadingFirst:(PlayingCardSetView *)first second:(PlayingCardSetView *)second third:(PlayingCardSetView *)third{
    
    if([first.shading isEqualToString:second.shading] && [first.shading isEqualToString:third.shading] && [second.shading isEqualToString:third.shading]){
        return true;
    }
    
    if(![first.shading isEqualToString:second.shading] && ![first.shading isEqualToString:third.shading] && ![second.shading isEqualToString:third.shading]){
        return true;
    }
    return false;
}

- (BOOL)matchColorFirst:(PlayingCardSetView *)first second:(PlayingCardSetView *)second third:(PlayingCardSetView *)third{
    
    if([first.shape isEqual:second.shape] && [first.shape isEqual:third.shape] && [second.shape isEqual:third.shape]){
        return true;
    }
    
    if(![first.shape isEqual:second.shape] && ![first.shape isEqual:third.shape] && ![second.shape isEqual:third.shape]){
        return true;
    }
    
    return false;
}

- (BOOL)matchRankFirst:(PlayingCardSetView *)first second:(PlayingCardSetView *)second third:(PlayingCardSetView *)third{
    
    if(first.rank == second.rank && first.rank == third.rank && second.rank == third.rank){
        return true;
    }
    
    if(!(first.rank == second.rank) && !(first.rank == third.rank) && !(second.rank == third.rank)){
        return true;
    }
    
    return false;
}


+ (NSArray *)validShape {
    //□
    return @[@"squiggle",@"oval",@"diamond"];
    
}

+ (NSArray *)validColors{
    return @[@"green",@"purple",@"red"];
}


+ (NSArray *)validShades{
    return @[@"fill",@"blank",@"stripped"];
}



- (void)setShape:(NSString *)shape{
    if([[PlayingCardSetView validShape] containsObject:shape]){
        _shape = shape;
    }
    
}

@end
