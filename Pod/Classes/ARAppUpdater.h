//
//  ARAppUpdater.h
//  Pods
//
//  Created by Alex M Reynolds on 12/7/15.
//
//

#import <Foundation/Foundation.h>

extern NSString const *kAPAUpdateRequired;
extern NSString const *kAPACustomUpdateURL;
extern NSString const *kAPACustomVersionURL;
extern NSString const *kAPACustomVersionKeyPath;
extern NSString const *kAPAAppId;


@interface ARAppUpdater : NSObject

- (instancetype)initWithOptions:(NSDictionary*)options;
- (void)checkForUpdate:(void (^)(void))completion;

@end
