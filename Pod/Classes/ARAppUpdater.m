//
//  ARAppUpdater.m
//  Pods
//
//  Created by Alex M Reynolds on 12/7/15.
//
//

#import "ARAppUpdater.h"
#import <AFNetworking/AFNetworking.h>


NSString const *kAPAUpdateRequired          = @"kAPAUpdateRequired";
NSString const *kAPACustomUpdateURL         = @"kAPACustomUpdateURL";
NSString const *kAPACustomVersionURL        = @"kAPACustomVersionURL";
NSString const *kAPACustomVersionKeyPath    = @"kAPACustomVersionKeyPath";
NSString const *kAPAAppId                   = @"kAPAAppId";


static NSString *CURRENT_VERSION;
NSString * const ARAppUpdaterMinimumAppVersionRequired = @"min_required_app_version";
NSString * const ARAppUpdaterShowAlertKey = @"ARAppUpdaterShowAlertKey";

typedef void(^updaterCompletionBlock)(void);

@interface ARAppUpdater()<UIAlertViewDelegate>
@property (nonatomic,strong) updaterCompletionBlock completion;
@property (nonatomic,strong) NSDictionary *options;
@end

@implementation ARAppUpdater

- (instancetype)initWithOptions:(NSDictionary *)options
{
    self = [super init];
    self.options = options;
    return self;
}

+ (void)initialize
{
    CURRENT_VERSION = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (void)checkForUpdate:(void (^)(void))completion
{
    if([self customVersionURL]){
        [self checkForAppUpdateFromURL:[self customVersionURL] completion:completion];
    }else {
        [self checkForAppStoreUpdate:completion];
    }
}

- (void)checkForAppUpdateFromURL:(NSString*)urlString completion:(void(^)(void))completion
{
    self.completion = completion;
    
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] init];
    [mgr GET:urlString parameters:nil success:^void(NSURLSessionDataTask * task, NSDictionary *response) {
        NSArray *keyPathPaths = [self customVersionKeyPath];
        __block NSDictionary *subObject = response;
        __block NSString *version;
        [keyPathPaths enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL *stop) {
            id result = [subObject objectForKey:keyPath];
            if([result isKindOfClass:[NSString class]]){
                version = result;
            }else {
                subObject = result;
            }
        }];
        [self compareResults:version];


    } failure:^void(NSURLSessionDataTask * task, NSError * error) {
        
    }];
}
- (void)checkForAppStoreUpdate:(void(^)(void))completion
{
    self.completion = completion;
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] init];
    [mgr GET:@"https://itunes.apple.com/lookup" parameters:@{@"id" : [self appId]} success:^void(NSURLSessionDataTask * task, id response) {
        NSString *version = [[[response objectForKey:@"results"] objectAtIndex:0] objectForKey:@"version"];
        [self compareResults:version];

    } failure:^void(NSURLSessionDataTask * task, NSError * error) {
        
    }];

}

- (void)compareResults:(NSString*)version
{
    
    if ([self currentVerion:[self currentVersion] isOlderThanAppStoreVersion:version] && [self shouldShowUpdateAlertForVersion:version]) {
        [self showUpdateModal];
    } else {
        if(self.completion)
            self.completion();
    }
}

- (BOOL)currentVerion:(NSString*)version isOlderThanAppStoreVersion:(NSString*)minVersion
{
    return [minVersion compare:version options:NSNumericSearch] == NSOrderedDescending;
}

- (void)showUpdateModal
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Update Available", @"Updater Modal Title") message:NSLocalizedString(@"An update is available in the app store", @"Update modal messahe") preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Update", @"Update modal button") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self updateURL]]];

    }]];
    
    if(![self forceUpdate]){
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"cancel modal button") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:ARAppUpdaterShowAlertKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }]];
    }
    
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:alert animated:YES completion:nil];
}

- (BOOL)shouldShowUpdateAlertForVersion:(NSString*)version
{
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:ARAppUpdaterShowAlertKey];
    if(oldVersion){
        return ![oldVersion isEqualToString:version] && ![self forceUpdate];

    }else {
        return YES;
    }
}
- (NSString*)currentVersion { return CURRENT_VERSION;}


- (NSString*)updateURL
{
    if(self.options && self.options[kAPACustomUpdateURL]){
        return self.options[kAPACustomUpdateURL];
    }else {
        return [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", [self appId]];
    }
  
}
- (NSArray*)customVersionKeyPath
{
    if(self.options && self.options[kAPACustomVersionKeyPath]){
        return [self.options[kAPACustomVersionKeyPath] componentsSeparatedByString:@"."];
    }else {
        return @[];
    }
}
- (NSString*)customVersionURL
{
    if(self.options && self.options[kAPACustomVersionURL]){
        return self.options[kAPACustomVersionURL];
    }else {
        return nil;
    }
}

- (NSString*)appId
{
    if(self.options && self.options[kAPAAppId]){
        return self.options[kAPAAppId];
    }else {
        return @"375380948";
    }
}
- (BOOL)forceUpdate
{
    if(self.options && self.options[kAPAUpdateRequired]){
        return [self.options[kAPAUpdateRequired] boolValue];
    }else {
        return NO;
    }
}

@end