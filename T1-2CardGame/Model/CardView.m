//
//  CardView.m
//  T1-2CardGame
//
//  Created by User on 14/12/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "CardView.h"

@implementation CardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(int)match:(NSArray *)othercards{//othercards is an argument
    
    int score = 0;
    
    /*
     for(Card *card in othercards){
     if([card.contents isEqualToString:self.contents]){
     score = 1;
     }
     }
     */
    
    return score;
    
}

@end
