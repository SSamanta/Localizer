//
//  LocalizationService.h
//  Localization
//
//  Created by Susim on 3/24/14.
//  Copyright (c) 2014 Susim. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ServiceHandler) (id object, NSError *error);
@interface LocalizationService : NSObject
+ (void)getLocalizedDataFromServiceURL:(NSString *)url onCompletion:(ServiceHandler)handler;
@end
