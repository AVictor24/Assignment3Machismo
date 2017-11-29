//
//  Content.m
//  T1-2CardGame
//
//  Created by User on 24/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "Content.h"

@implementation Content

+ (NSDictionary *)shapeColors {
    return  @{@"red":[UIColor redColor], @"purple":[UIColor purpleColor], @"green":[UIColor greenColor]};
}

+ (NSDictionary *)shades {
    return  @{@"fill":@-10, @"blank":@8, @"stripped":@-10};
}



+ (NSAttributedString *)setShapeAndColor: (NSString *)string color:(UIColor *)color shading:(NSNumber *)shading {
    NSDictionary *attrDict = @{ NSForegroundColorAttributeName : color , NSFontAttributeName:[UIFont systemFontOfSize:28], NSStrokeWidthAttributeName: shading, NSStrokeColorAttributeName: color};
    
    NSMutableAttributedString *AattrString = [[NSMutableAttributedString alloc] initWithString:string attributes: attrDict];
    
    return AattrString;
}


+ (NSAttributedString *)titleForCardSet:(PlayingCardSet *)card withBackSlash:(NSString *)bckSlash{
    UIColor *setCardColor = [[Content shapeColors] objectForKey:card.color];
    NSNumber *setCardShade = [[Content shades] objectForKey:card.shading];
    if([card.shading isEqualToString:@"stripped"]){
        setCardColor = [setCardColor colorWithAlphaComponent:0.2];
    }
    NSAttributedString *s = [self setShapeAndColor:card.shape color:setCardColor shading:setCardShade];
    
    NSMutableAttributedString *sMutable = [[NSMutableAttributedString alloc] initWithAttributedString:s];
    NSAttributedString *bck = [[NSAttributedString alloc] initWithString:bckSlash];
    // NSAttributedString *shading = [[NSAttributedString alloc] initWithString:card.shading];
    //[sMutable appendAttributedString:shading];
    for(int i = 0; i<card.rank -1 ; i++){
        [sMutable appendAttributedString:bck];
        [sMutable appendAttributedString:s];
    }
    
    //return [self setShapeAndColor:card.shape color:setCardColor];
    return sMutable;
}

@end
