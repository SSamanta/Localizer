//
//  LocalizationService.m
//  Localization
//
//  Created by Susim on 3/24/14.
//  Copyright (c) 2014 Susim. All rights reserved.
//

#import "LocalizationService.h"

@implementation LocalizationService
+ (void)getLocalizedDataFromServiceURL:(NSString *)url onCompletion:(ServiceHandler)handler {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            handler (nil,connectionError);
        }else if (data) {
            NSError *jsonError;
            id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            NSArray *list = (NSArray *)json;
            __block NSString *fullString=@"";
            [list enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                fullString = [NSString stringWithFormat:@"%@\"%@\" = \"%@\";\n",fullString, obj[@"ResourceKey"],obj [@"ResourceValue"]];
            }];
            if (jsonError) {
                handler(nil,jsonError);
            }else {
                handler (fullString,nil);
            }
        }else {
            NSError *noDataError = [NSError errorWithDomain:@"com.app.nodata" code:2004 userInfo:nil];
            handler (nil,noDataError);
        }
    }];
}
@end
