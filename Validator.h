//
//  Validator.h
//  Validator
//
//  Created by Cristian Malita on 02/06/15.
//  Copyright (c) 2015 Cristian Malita. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CNP_KEY 279146358279;
#define CIF_KEY 753217532;

@interface Validator : NSObject

+ (BOOL)isValidCNP:(NSString *)cnp;
+ (BOOL)isValidCIF:(NSString *)cif;
+ (BOOL)isValidIBAN:(NSString *)iban;
@end
