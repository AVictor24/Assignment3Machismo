//
//  Content.h
//  T1-2CardGame
//
//  Created by User on 24/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlayingCardSet.h"

@interface Content : NSObject

+ (NSAttributedString *)titleForCardSet:(PlayingCardSet *)card withBackSlash:(NSString *)bckSlash;

@end
