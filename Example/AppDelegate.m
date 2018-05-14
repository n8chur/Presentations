//
//  AppDelegate.m
//  AUTPresentations
//
//  Created by Westin Newell on 6/20/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "NSURL+AUTRoutes.h"

#import "RootViewController.h"
#import "RootViewModel.h"
#import "AUTExtObjC.h"
#import "ApplicationShortcutManager.h"

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate () <ApplicationShortcutItemActionHandler>

@property (readonly, nonatomic) ApplicationShortcutManager *applicationShortcutManager;

@property (readonly, nonatomic) RootViewModel *rootViewModel;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    
    _rootViewModel = [[RootViewModel alloc] init];
    self.window.rootViewController = [[RootViewController alloc] initWithViewModel:_rootViewModel];
    
    [self.window makeKeyAndVisible];
    
    _applicationShortcutManager = [[ApplicationShortcutManager alloc] initWithRouter:_rootViewModel.router handler:self];
    
    application.shortcutItems = _applicationShortcutManager.items;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    let rootViewModel = self.rootViewModel;
    if ([url.scheme isEqualToString:AUTRouteURLScheme] && rootViewModel != nil) {
        if (!url.aut_isRoutable) return NO;
        
        [rootViewModel.router.handleURL execute:RACTuplePack(url, nil)];
        return YES;
    }
    
    return NO;
}

// Provide liftable selectors for ApplicationShortcutItemActionHandler. Done in
// this way as UIApplication queries respondsToSelector: at launch time, and
// dynamically implementing these methods will happen after respondsToSelector:
// is invoked.
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {}


@end

NS_ASSUME_NONNULL_END
