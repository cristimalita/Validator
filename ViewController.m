//
//  ViewController.m
//  Validator
//
//  Created by Cristian Malita on 02/06/15.
//  Copyright (c) 2015 Cristian Malita. All rights reserved.
//

#import "ViewController.h"
#import "Validator.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIImageView *validImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)validate:(id)sender {
    NSInteger segmentIndex = [self.segment selectedSegmentIndex];
    NSString *code = self.textField.text;
    
    switch (segmentIndex) {
        case 0:
            if ([Validator isValidCNP:code]) {
                self.resultLabel.text = @"Codul este un CNP valid!";
                self.validImage.image = [UIImage imageNamed:@"success"];
            } else {
                self.resultLabel.text = @"Codul este un CNP invalid!";
                 self.validImage.image = [UIImage imageNamed:@"fail"];
                
            }
            break;
        case 1:
            if ([Validator isValidCIF:code]) {
                self.resultLabel.text = @"Codul este un CIF valid!";
                self.validImage.image = [UIImage imageNamed:@"success"];
            } else {
                self.resultLabel.text = @"Codul este un CIF invalid!";
                self.validImage.image = [UIImage imageNamed:@"fail"];
            }

            break;
            
        case 2:
            
            if ([Validator isValidIBAN:code]) {
                self.resultLabel.text = @"Codul este un IBAN valid!";
                self.validImage.image = [UIImage imageNamed:@"success"];
            } else {
                self.resultLabel.text = @"Codul este un IBAN invalid!";
                self.validImage.image = [UIImage imageNamed:@"fail"];
            }

            
            break;
            
        default:
            self.resultLabel.text = @"Cod invalid!";
            break;
    }
    

}

- (IBAction)changedSegment:(id)sender {
    NSInteger segmentIndex = [self.segment selectedSegmentIndex];
    switch (segmentIndex) {
        case 0:
            [self.textField resignFirstResponder];
            [self.textField setKeyboardType:UIKeyboardTypeNumberPad];
            [self.textField becomeFirstResponder];
            break;
        case 1:
            [self.textField resignFirstResponder];
            [self.textField setKeyboardType:UIKeyboardTypeNumberPad];
            [self.textField becomeFirstResponder];
            break;
        case 2:
            [self.textField resignFirstResponder];
            [self.textField setKeyboardType:UIKeyboardTypeASCIICapable];
            [self.textField becomeFirstResponder];
            break;
            
        default:
            [self.textField resignFirstResponder];
            [self.textField setKeyboardType:UIKeyboardTypeNumberPad];
            [self.textField becomeFirstResponder];
            break;
    }

}

@end
