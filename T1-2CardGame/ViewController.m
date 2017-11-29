//
//  ViewController.m
//  T1-2CardGame
//
//  Created by User on 02/11/2017.
//  Copyright © 2017 User. All rights reserved.
//


#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface ViewController ()





@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;




@end


@implementation ViewController

/*
 @synthesize numberOfMatches;
 - (BOOL)textFieldShouldReturn:(UITextField *)textField{
 return YES;
 }
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.numberOfMatches.delegate = self;
    
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    
    self.historyText = [[NSMutableAttributedString alloc]initWithString:@""];
    
    [self updateUI];
}

- (Deck *)createDeck{ //abstract
    //return [[PlayingCardDeck alloc] init];
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)touchSegmentButton:(UISegmentedControl *)sender {
    
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            [self.game setNumberOfMatches:2];
            break;
        case 1:
            [self.game setNumberOfMatches:3];
            break;
        case 2:
            [self.game setNumberOfMatches:4];
            break;
            
        default:
            break;
    }
}
- (IBAction)touchRedealButton:(UIButton *)sender {
    
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.enabled = true;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    self.segmentControl.enabled = false;
    [self updateUI];
}

- (void)updateUI{
    
    for(UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        cardButton.titleLabel.numberOfLines = 0;
        cardButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        //self.infoLabel.text = [self.game getDisplay];
        self.infoLabel.attributedText = [self.game getDisplay];

       
    }
     NSAttributedString *bck = [[NSAttributedString alloc] initWithString:@"\n"];
    if([[self.game isMatch] isEqual:@1]){
        
        [self.game setMatch:@0];
        
        NSMutableAttributedString* ss = [[NSMutableAttributedString alloc] initWithAttributedString:self.historyText];
        [ss appendAttributedString:[self.game getDisplay]];
        
        if(![self.historyText isEqualToAttributedString: ss]){
        
        
            [self.historyText appendAttributedString:[self.game getDisplay]];
            [self.historyText appendAttributedString:bck];
            
            
        }
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"History"]){
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]]){
            HistoryViewController *tsvc = (HistoryViewController *)segue.destinationViewController;
            
            tsvc.textToAnalyze = self.historyText;
            
        }
    }
}

- (NSAttributedString *)titleForCard:(Card *)card{
    NSAttributedString *content = [[NSAttributedString alloc] initWithAttributedString:card.contents];
    
    if(card.isChosen){
        return content;
    }
    
    return [[NSAttributedString alloc] initWithString:@""];
    
  // return [[NSAttributedString alloc] initWithAttributedString:card.isChosen ? card.contents :@""];  // return content otherwise reuturn ""
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"lights"];
}

@end









