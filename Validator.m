//
//  Validator.m
//  Validator
//
//  Created by Cristian Malita on 02/06/15.
//  Copyright (c) 2015 Cristian Malita. All rights reserved.
//

#import "Validator.h"

static NSString* const Letters = @"ABCDEFGHIJKLKMNOPQRSTUVWXYZ";
static NSString* const Decimals = @"0123456789";
static NSString* const LettersAndDecimals = @"ABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789";

@implementation Validator

+ (BOOL)isValidCNP:(NSString *)cnp {
    
    int c, sum;
    unsigned long long code, key;
    
    code = [cnp longLongValue];
    key = CNP_KEY;
    
    if ([cnp length] != 13 || code == 0) {
        return NO;
    }
    

    
    c = code % 10;
    code /= 10;
    
    sum = 0;
    
    while (code != 0) {
        sum += (code % 10) * (key % 10);
        code /= 10;
        key /= 10;
    }
    
    sum = sum % 11;
    
    sum = (sum == 10) ? 1 : sum;
    
    
    return sum == c;
}

+ (BOOL)isValidCIF:(NSString *)cif {
    
    int c, sum;
    
    unsigned long long key, code;
    code = [cif longLongValue];
    key = CIF_KEY;
    
    if ([cif length] < 6 || [cif length] > 10 || code == 0) {
        return NO;
    }
    
    c = code % 10;
    sum = 0;
    
    code /= 10;
    
    while (code != 0) {
        sum += (code % 10) * (key % 10);
        code /= 10;
        key /= 10;
    }
    
    sum = (sum * 10) % 11;
    
    sum = (sum==10) ? 0 : sum;
    
    
    return sum == c;
}

+ (BOOL)isValidIBAN:(NSString *)iban {
    
    //Remove whitespace and convert to uppercase string
    iban = [[iban stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
    
    //All non alphanumeric characters are invalid
    NSCharacterSet *invalidChars = [[NSCharacterSet characterSetWithCharactersInString:LettersAndDecimals] invertedSet];
    
    //If any invalid chars are found, return NO
    if ([iban rangeOfCharacterFromSet:invalidChars].location != NSNotFound)
    {
        return NO;
    }
    
    
    int checkDigit = [iban substringWithRange:NSMakeRange(2, 2)].intValue;
    iban = [NSString stringWithFormat:@"%@%@",[iban substringWithRange:NSMakeRange(4, iban.length - 4)], [iban substringWithRange:NSMakeRange(0, 4)]] ;
    
    for (int i = 0; i < iban.length; i++) {
        unichar c = [iban characterAtIndex:i];
        if (c >= 'A' && c <= 'Z') {
            iban = [NSString stringWithFormat:@"%@%d%@", [iban substringWithRange:NSMakeRange(0, i)], (c - 'A' + 10),[iban substringWithRange:NSMakeRange(i+1, iban.length - i - 1)]];
        }
        
    }
    iban = [[iban substringWithRange:NSMakeRange(0, iban.length - 2)] stringByAppendingString:@"00"];
    
    while(true)
    {
        int iMin = (int)MIN(iban.length, 9);
        NSString* strPart = [iban substringWithRange:NSMakeRange(0, iMin)];
        int decnumber = strPart.intValue;
        if(decnumber < 97 || iban.length < 3)
            break;
        int del = decnumber % 97;
        iban =  [NSString stringWithFormat:@"%d%@", del, [iban substringFromIndex:iMin]];
    }
    int check = 98 - iban.intValue;
    
    return checkDigit == check;
}

@end
