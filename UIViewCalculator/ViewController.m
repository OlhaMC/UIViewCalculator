//
//  ViewController.m
//  UIViewCalculator
//
//  Created by Admin on 01.10.15.
//  Copyright (c) 2015 Olha Fizer. All rights reserved.
//

#import "ViewController.h"
#import "RationalNumbers.h"
#import "OFCalculator.h"

@interface ViewController ()

@property (strong, nonatomic) OFCalculator * myCalculator;
@property (assign, nonatomic) NSInteger temporaryNumber;

@property (assign, nonatomic) BOOL didFinishEnteringNumerator;
@property (assign, nonatomic) BOOL didEnterOperation;

- (IBAction) enterDigitAction: (UIButton*)sender;
- (IBAction) addSlashAction: (UIButton*)sender;
- (IBAction) equalsAction: (UIButton*)sender;

- (IBAction) plusAction: (UIButton*)sender;
- (IBAction) subtractAction: (UIButton*)sender;
- (IBAction) multiplyAction: (UIButton*)sender;
- (IBAction) divideAction: (UIButton*)sender;

- (IBAction) clearAllAction: (UIButton*)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    UIGraphicsBeginImageContext(self.calculatorBaseView.frame.size);
    [[UIImage imageNamed:@"Space2.jpg"] drawInRect:self.calculatorBaseView.bounds];
    UIImage * baseImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.calculatorBaseView.backgroundColor = [UIColor colorWithPatternImage:baseImage];
    
    self.calculatorBaseView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    self.enterAreaLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.enterAreaLabel.text=@"";
    
    self.myCalculator = [OFCalculator createCalculator];
    self.temporaryNumber = 0;
    self.didFinishEnteringNumerator = NO;
    self.didEnterOperation = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Inner methods
- (void) defineNumeratorOrDenominator
{
    RationalNumbers * temporaryFraction = [[RationalNumbers alloc]init];
    if (self.didFinishEnteringNumerator)
    {
        if (self.temporaryNumber == 0)
        {
            [self clearAllAction:nil];
            self.enterAreaLabel.text  =[NSString stringWithFormat:@"Can't be divided by zero. Press 'Clear all' button"];
            return;
        }
        else
        {
            temporaryFraction = self.myCalculator.rationalNumbersArray.lastObject;
            temporaryFraction.denominator = self.temporaryNumber;
            [self.myCalculator.rationalNumbersArray removeLastObject];
        }
    }
    else
    {
        if (self.temporaryNumber == 0)
        {
            return;
        }
        temporaryFraction.numerator = self.temporaryNumber;
        temporaryFraction.denominator = 1;
    }
    
    [self.myCalculator.rationalNumbersArray addObject:[temporaryFraction copy]];
    self.didFinishEnteringNumerator = NO;
    self.temporaryNumber = 0;
}

-(void) removeObjectsAtIndexes: (NSUInteger) indexI
{
    [self.myCalculator.rationalNumbersArray removeObjectAtIndex:indexI+1];
    [self.myCalculator.mathematicOperationsArray removeObjectAtIndex:indexI];
}

- (void) finishNumberForOperationButton: (UIButton*) sender
{
    [self.myCalculator.mathematicOperationsArray addObject:@(sender.tag)];
    self.didEnterOperation = YES;
    [self defineNumeratorOrDenominator];
}

- (void) show
{
  if ([self.myCalculator.rationalNumbersArray[0] denominator] == 1)
  {
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:[NSString stringWithFormat:@"= %ld", [self.myCalculator.rationalNumbersArray[0] numerator]]];
  }
  else
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:[NSString stringWithFormat:@"= %ld/%ld", [self.myCalculator.rationalNumbersArray[0] numerator],
                                                                                [self.myCalculator.rationalNumbersArray[0] denominator]]];
}

#pragma mark - UICalculator methods
-(IBAction)enterDigitAction:(UIButton*)sender
{
    self.temporaryNumber = self.temporaryNumber * 10 + sender.tag;
    
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:[NSString stringWithFormat:@"%ld", sender.tag]];
    self.didEnterOperation = NO;
}

-(IBAction)addSlashAction:(UIButton*)sender
{
    RationalNumbers * currentNumber = [[RationalNumbers alloc]init];
    
    currentNumber.numerator = self.temporaryNumber;
        self.temporaryNumber = 0;
    [self.myCalculator.rationalNumbersArray addObject: [currentNumber copy]];
    self.didFinishEnteringNumerator = YES;
    self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@"/"];

}

-(IBAction)equalsAction:(UIButton*)sender
{
    [self defineNumeratorOrDenominator];
    if (self.myCalculator.rationalNumbersArray.count <= 1)
    {
        return;
    }
    
    for (NSUInteger i = 0; i < self.myCalculator.mathematicOperationsArray.count; i++)
    {
        switch ([self.myCalculator.mathematicOperationsArray[i] integerValue])
        {
            case 13:
                self.myCalculator.rationalNumbersArray[i]=
                [self.myCalculator multiply:self.myCalculator.rationalNumbersArray[i]
                                        and:self.myCalculator.rationalNumbersArray[i+1]];
                [self removeObjectsAtIndexes:i];
                i-=1;
                break;
            case 14:
                self.myCalculator.rationalNumbersArray[i]=
                [self.myCalculator divide:self.myCalculator.rationalNumbersArray[i]
                                        and:self.myCalculator.rationalNumbersArray[i+1]];
                [self removeObjectsAtIndexes:i];
                i-=1;
                break;
        }
    }

    for ( ; self.myCalculator.rationalNumbersArray.count > 1; )
        {
            switch ([self.myCalculator.mathematicOperationsArray[0] integerValue])
            {
                case 11:
                    self.myCalculator.rationalNumbersArray[0]=
                    [self.myCalculator add:self.myCalculator.rationalNumbersArray[0]
                                            and:self.myCalculator.rationalNumbersArray[1]];
                    [self removeObjectsAtIndexes:0];
                    break;
                case 12:
                    self.myCalculator.rationalNumbersArray[0]=
                    [self.myCalculator subtract:self.myCalculator.rationalNumbersArray[0]
                                       and:self.myCalculator.rationalNumbersArray[1]];
                    [self removeObjectsAtIndexes:0];
                    break;
            }
        }
    [self show];
}

-(IBAction)plusAction:(UIButton*)sender
{
    if (self.didEnterOperation)
    {
        return;
    }
    else
    {
        [self finishNumberForOperationButton:sender];
        self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@"+"];
    }
}

- (IBAction) subtractAction: (UIButton*)sender
{
    if (self.didEnterOperation)
    {
        return;
    }
    else
    {
        [self finishNumberForOperationButton:sender];
        self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@"-"];
    }
}

- (IBAction) multiplyAction: (UIButton*)sender
{
    if (self.didEnterOperation)
    {
        return;
    }
    else
    {
        [self finishNumberForOperationButton:sender];
        self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@"*"];
    }
}
- (IBAction) divideAction: (UIButton*)sender
{
    if (self.didEnterOperation)
    {
        return;
    }
    else
    {
        [self finishNumberForOperationButton:sender];
        self.enterAreaLabel.text=[self.enterAreaLabel.text stringByAppendingString:@":"];
    }
}
-(IBAction)clearAllAction:(UIButton*)sender
{
    self.temporaryNumber = 0;
    self.didFinishEnteringNumerator = NO;
    
    [self.myCalculator.rationalNumbersArray removeAllObjects];
    [self.myCalculator.mathematicOperationsArray removeAllObjects];
    self.enterAreaLabel.text=@"";
}

- (IBAction) chandeSignAction:(UIButton*)sender
{
    if (self.myCalculator.mathematicOperationsArray.count != 0)
    {
        return;
    }
    if (self.myCalculator.rationalNumbersArray.count > 1 )
    {
        return;
    }
    self.temporaryNumber = - (self.temporaryNumber);
    if (self.temporaryNumber < 0)
        self.enterAreaLabel.text=[NSString stringWithFormat:@"-%@",self.enterAreaLabel.text];
    else
        self.enterAreaLabel.text=[self.enterAreaLabel.text substringFromIndex:1];
}

@end
