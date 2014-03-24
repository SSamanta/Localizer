//
//  MainWindow.m
//  Localizer
//
//  Created by Susim on 3/24/14.
//  Copyright (c) 2014 Susim. All rights reserved.
//

#import "MainWindow.h"
#import "LocalizationService.h"

@interface MainWindow ()
- (IBAction)fetch:(id)sender;
@property (nonatomic) IBOutlet NSTextField *inputTf;
@property (nonatomic) IBOutlet NSTextField *outputFileLocationTf;
@end
@implementation MainWindow
- (IBAction)fetch:(id)sender {
    [LocalizationService getLocalizedDataFromServiceURL:self.inputTf.stringValue onCompletion:^(NSString *fullString, NSError *error) {
        if (error) {
            self.outputFileLocationTf.stringValue =  error.debugDescription;
        }else {
            NSData *fileData = [fullString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *fileError = nil;
            NSString *filepath = @"~/Desktop/Localizable.strings";
            filepath = [filepath stringByExpandingTildeInPath];
            [fileData writeToFile:filepath options:NSDataWritingAtomic error:&fileError];
            self.outputFileLocationTf.stringValue = @"Please check your localizable file here : ~/Desktop/Localizable.strings";
            if (fileError) {
                self.outputFileLocationTf.stringValue =  fileError.debugDescription;
            }
        }
    }];
}
@end
