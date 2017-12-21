//
//  SetGameViewController.m
//  T1-2CardGame
//
//  Created by User on 22/11/2017.
//  Copyright © 2017 User. All rights reserved.
//

#import "SetGameViewController.h"
#import "Grid.h"
#import "Draw.h"
#import "CardView.h"
#import "CardMatchingGameView.h"
#import "PlayingCardSetViewDeck.h"
#import "PlayingCardSetView.h"
#import <QuartzCore/QuartzCore.h>

@interface SetGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (strong, nonatomic) Grid *grid;
@property (nonatomic) NSInteger currentCardsOnTable;
@property (nonatomic) NSInteger addedCards;
@property (nonatomic) BOOL stack;
@property (nonatomic) CGPoint stackpoint;
//@property (nonatomic) NSInteger currentMinimumCardsOnTable;

@end

@implementation SetGameViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.stack = NO;
    self.stackpoint = CGPointMake(0,0);
    self.addedCards = 0;
    self.currentCardsOnTable = 12;
    // self.currentMinimumCardsOnTable = 12;
    
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.game2 = [[CardMatchingGameView alloc] initWithCardCount:81 usingDeck:[[PlayingCardSetViewDeck alloc] init]];
        
        self.grid = [[Grid alloc] init];
        self.grid.cellAspectRatio = 0.5;
        
        self.grid.size = self.gridView.bounds.size;
        self.grid.minimumNumberOfCells = self.currentCardsOnTable;
        
        
        //[self updateUI];
        [self updateUIAnimated];
        // initial animation
        
    });
}

- (IBAction)handlePinchGesture:(UIPinchGestureRecognizer *)sender {
    
    for(int i= 0 ; i < self.currentCardsOnTable ; i++){
        
        PlayingCardSetView *card = [self.game2 cardAtIndex:i];
        
        
        // [UIView animateWithDuration:2 animations:^{card.frame = CGRectOffset(card.frame, 0, 250); }];
        
        [UIView animateWithDuration:0.3 animations:^{card.center = CGPointMake(30, 60); } ];
        
        
    }
    self.stack = YES;
}


-(void)move:(UIPanGestureRecognizer*)sender {
    
    CGPoint savedTranslation;
    
    if(self.stack){
        CGPoint netTranslation;
        for(int i= 0 ; i < self.currentCardsOnTable ; i++){
            
            PlayingCardSetView *card = [self.game2 cardAtIndex:i];
            
            
            CGPoint translation = [(UIPanGestureRecognizer *) sender translationInView:card];
            
            
            card.transform = CGAffineTransformMakeTranslation(netTranslation.x + translation.x, netTranslation.y + translation.y);
            
            
            savedTranslation.x += translation.x;
            savedTranslation.y += translation.y;
            
            card.center = CGPointMake(card.center.x + savedTranslation.x, card.center.y + savedTranslation.y);
            [sender setTranslation:CGPointZero inView:card];
            
            self.stackpoint = card.center;
            
        }
        
    }
    
}

- (void) orientationChanged:(NSNotification *)note
{
    NSLog(@"");
    
    //[self refreshCards];
    
    self.grid.size = self.gridView.bounds.size;
    
    [self updateUI];
}

- (void)handleUIUpdateWithMatch:(BOOL)matched {
    if(matched){
        self.currentCardsOnTable -= 3;
        //self.grid.minimumNumberOfCells = self.currentCardsOnTable;
        [self updateUI];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game2.score];
    
    
    if(self.stack){
        
        for(int i= 0 ; i < self.currentCardsOnTable ; i++){
            
            PlayingCardSetView *card = [self.game2 cardAtIndex:i];
            
            UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleTap:)];
            [card addGestureRecognizer:singleFingerTap];
            
            UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
            [panRecognizer setMinimumNumberOfTouches:1];
            [panRecognizer setMaximumNumberOfTouches:1];
            [card addGestureRecognizer:panRecognizer];
            
            CGRect rect = [self.grid frameOfCellAtRow:i/self.grid.columnCount inColumn:i % self.grid.columnCount];
            
            
            card.frame = CGRectMake(self.stackpoint.x, self.stackpoint.y, rect.size.width - 20, rect.size.height - 20);
            
            
            [UIView animateWithDuration:0.3 animations:^{
                
                card.frame = CGRectMake(rect.origin.x + 10,rect.origin.y + 10, rect.size.width - 20, rect.size.height - 20); }];
            
            card.backgroundColor = [UIColor whiteColor];
            
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game2.score];
            
            [self.gridView addSubview:card];
            
            //[UIView animateWithDuration:10 animations:^{card.frame = CGRectOffset(card.frame, 0, 250);; }];
            
        }
        
        self.stack = NO;
    }
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    
    
    [self.game2 chooseCard:(Draw *)recognizer.view];
    
    [UIView transitionWithView:recognizer.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
    
    
    NSMutableArray *toRemove = [[NSMutableArray alloc] init];
    
    BOOL matched = NO;
    
    for(Draw *card in self.game2.cards){
        if(card.isChosen){
            
            
    
            card.layer.masksToBounds = NO;
            card.layer.shadowOffset = CGSizeMake(-15, 20);
            card.layer.shadowRadius = 5;
            card.layer.shadowOpacity = 0.5;
            
        }
        else{
            card.backgroundColor = [UIColor whiteColor];
            
            card.layer.masksToBounds = YES;
            //card.layer.shadowOffset = CGSizeMake(-15, 20);
            card.layer.shadowRadius = 0;
            card.layer.shadowOpacity = 0;
            
        }
        
        if(card.isMatched){
            //remove card
            [toRemove addObject:card];
            
            
            matched = YES;
        }
        
    }
    
    if (toRemove != nil && toRemove.count > 0) {
        [UIView animateWithDuration:0.3 animations:^{
            for(Draw *cardremove in toRemove){
                cardremove.center = CGPointMake(-self.view.bounds.size.width, -self.view.bounds.size.height);
                
            }
        } completion:^(BOOL finished) {
            for(Draw *cardremove in toRemove){
                [cardremove removeFromSuperview];
                [self.game2.cards removeObject:cardremove];
            }
            [self handleUIUpdateWithMatch:matched];
        }];
        return;
    }
    
    [self handleUIUpdateWithMatch:matched];
}

- (void)updateUI{
    
    
    for(int i= 0 ; i < self.currentCardsOnTable ; i++){
        
        PlayingCardSetView *card = [self.game2 cardAtIndex:i];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [card addGestureRecognizer:singleFingerTap];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [card addGestureRecognizer:panRecognizer];
        
        CGRect rect = [self.grid frameOfCellAtRow:i/self.grid.columnCount inColumn:i % self.grid.columnCount];
        
        card.frame = CGRectMake(rect.origin.x + 10,rect.origin.y + 10, rect.size.width - 20, rect.size.height - 20);
        
        card.backgroundColor = [UIColor whiteColor];
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game2.score];
        
        [self.gridView addSubview:card];
        
        //[UIView animateWithDuration:10 animations:^{card.frame = CGRectOffset(card.frame, 0, 250);; }];
        
    }
}

- (void)updateUIAnimated{
    
    
    for(int i= 0 ; i < self.currentCardsOnTable ; i++){
        
        PlayingCardSetView *card = [self.game2 cardAtIndex:i];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [card addGestureRecognizer:singleFingerTap];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
        [panRecognizer setMinimumNumberOfTouches:1];
        [panRecognizer setMaximumNumberOfTouches:1];
        [card addGestureRecognizer:panRecognizer];
        
        CGRect rect = [self.grid frameOfCellAtRow:i/self.grid.columnCount inColumn:i % self.grid.columnCount];
        
        int widthfar = self.gridView.bounds.size.width /2;
        int heigthfar = -self.gridView.bounds.size.height /2;
        
        card.frame = CGRectMake(widthfar,heigthfar, rect.size.width - 20, rect.size.height - 20);
        
        widthfar -= rect.size.width ;
        heigthfar -= rect.size.height ;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            card.frame = CGRectMake(rect.origin.x + 10,rect.origin.y + 10, rect.size.width - 20, rect.size.height - 20); }];
        
        card.backgroundColor = [UIColor whiteColor];
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game2.score];
        
        [self.gridView addSubview:card];
        
        //[UIView animateWithDuration:10 animations:^{card.frame = CGRectOffset(card.frame, 0, 250);; }];
        
    }
    
}

-(DeckView *)createDeck{
    return [[PlayingCardSetViewDeck alloc] init];
}


- (IBAction)touchRedealButton:(UIButton *)sender {
    
    self.currentCardsOnTable = 12;
    self.grid.minimumNumberOfCells = self.currentCardsOnTable;
    
    for(Draw* draw in self.game2.cards){
        [draw removeFromSuperview];
    }
    
    self.game2 = [[CardMatchingGameView alloc] initWithCardCount:81 usingDeck:[[PlayingCardSetViewDeck alloc] init]];
    // [self updateUI];
    [self updateUIAnimated];
    
}
- (IBAction)cardsPressed:(UIBarButtonItem *)sender {
    //add 3 cards
    
    if(self.currentCardsOnTable <= 81){
        
       
        
        
        for(int i= 0 ; i < self.currentCardsOnTable ; i++){
            
            PlayingCardSetView *card = [self.game2 cardAtIndex:i];
            [card removeFromSuperview];
        }
        
        
        
        for(int i= 0 ; i < self.currentCardsOnTable ; i++){
            
            PlayingCardSetView *card = [self.game2 cardAtIndex:i];
            
            UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleTap:)];
            [card addGestureRecognizer:singleFingerTap];
            
            UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
            [panRecognizer setMinimumNumberOfTouches:1];
            [panRecognizer setMaximumNumberOfTouches:1];
            [card addGestureRecognizer:panRecognizer];
            
            CGRect rect = [self.grid frameOfCellAtRow:i/self.grid.columnCount inColumn:i % self.grid.columnCount];
            
            card.frame = CGRectMake(rect.origin.x + 10,rect.origin.y + 10, rect.size.width - 20, rect.size.height - 20);
            
            card.backgroundColor = [UIColor whiteColor];
            
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game2.score];
            
            [self.gridView addSubview:card];
            
            //[UIView animateWithDuration:10 animations:^{card.frame = CGRectOffset(card.frame, 0, 250);; }];
            
        }
        
        
        
        for(NSInteger i= self.currentCardsOnTable ; i < self.currentCardsOnTable + 3 ; i++){
            
            PlayingCardSetView *card = [self.game2 cardAtIndex:i];
            
            UITapGestureRecognizer *singleFingerTap =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleTap:)];
            [card addGestureRecognizer:singleFingerTap];
            
            UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
            [panRecognizer setMinimumNumberOfTouches:1];
            [panRecognizer setMaximumNumberOfTouches:1];
            [card addGestureRecognizer:panRecognizer];
            
            CGRect rect = [self.grid frameOfCellAtRow:i/self.grid.columnCount inColumn:i % self.grid.columnCount];
            
            card.frame = CGRectMake(self.view.bounds.size.width,self.view.bounds.size.height, rect.size.width - 20, rect.size.height - 20);
            
            
            
            [UIView animateWithDuration:0.3 animations:^{
                
                card.frame = CGRectMake(rect.origin.x + 10,rect.origin.y + 10, rect.size.width - 20, rect.size.height - 20); }];
            
            card.backgroundColor = [UIColor whiteColor];
            
            self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game2.score];
            
            [self.gridView addSubview:card];
            
            //[UIView animateWithDuration:10 animations:^{card.frame = CGRectOffset(card.frame, 0, 250);; }];
            
        }
        
        self.currentCardsOnTable += 3;
        self.grid.minimumNumberOfCells = self.currentCardsOnTable;
        
    }
    
    
}

@end
