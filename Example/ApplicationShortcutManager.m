//
//  ApplicationShortcutManager.m
//  Example
//
//  Created by Westin Newell on 6/22/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import ReactiveObjC;

#import "NSURL+AUTRoutes.h"

#import "AUTExtObjC.h"

#import "ApplicationShortcutManager.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ApplicationShortcutManager

#pragma mark - Lifecycle

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithRouter:(AUTRouter *)router handler:(NSObject<ApplicationShortcutItemActionHandler> *)handler {
    AUTAssertNotNil(router, handler);
    
    self = [super init];
    
    let catOne = [[UIApplicationShortcutItem alloc]
        initWithType:@"CatOne"
        localizedTitle:[NSURL aut_catRouteURLWithCatName:@"Simba"].absoluteString];
    
    let catOneImage = [[UIApplicationShortcutItem alloc]
        initWithType:@"CatOneImage"
        localizedTitle:[NSURL aut_catImageRouteURLWithCatName:@"Tigger"].absoluteString];
        
    let add = [[UIApplicationShortcutItem alloc]
        initWithType:@"Add"
        localizedTitle:[NSURL aut_addCatRouteURL].absoluteString];
        
    let about = [[UIApplicationShortcutItem alloc]
        initWithType:@"About"
        localizedTitle:[NSURL aut_aboutRouteURL].absoluteString];
        
    let faq = [[UIApplicationShortcutItem alloc]
        initWithType:@"FAQ"
        localizedTitle:[NSURL aut_faqRouteURL].absoluteString];
    
    _items = @[ catOneImage, add, about, faq, catOne ];
    
    [[[self routeToShortcutItemActionsWithRouter:router handler:handler]
        takeUntil:self.rac_willDeallocSignal]
        subscribeCompleted:^{}];
    
    return self;
}

#pragma mark - ApplicationShortcutManager

#pragma mark Private

- (RACSignal *)routeToShortcutItemActionsWithRouter:(AUTRouter *)router handler:(NSObject<ApplicationShortcutItemActionHandler> *)handler {
    AUTAssertNotNil(router, handler);
    
    let actionHandlerCallbacks = [[handler rac_signalForSelector:@selector(application:performActionForShortcutItem:completionHandler:) fromProtocol:@protocol(ApplicationShortcutItemActionHandler)]
        reduceEach:^(id _, UIApplicationShortcutItem *shortcutItem, void (^completionHandler)(BOOL)) {
            return [RACTwoTuple pack:shortcutItem :completionHandler];
        }];
        
    let launchNotifications = [[[[NSNotificationCenter.defaultCenter rac_addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil]
        map:^(NSNotification *notification) {
            return notification.userInfo[UIApplicationLaunchOptionsShortcutItemKey];
        }]
        ignore:nil]
        map:^(UIApplicationShortcutItem *shortcutItem){
            void (^completionHandler)(BOOL) = ^(BOOL successful){};
            return [RACTwoTuple pack:shortcutItem :completionHandler];
        }];
        
    return [[[RACSignal merge:@[ actionHandlerCallbacks, launchNotifications ]]
        reduceEach:^(UIApplicationShortcutItem *item, void (^completionHandler)(BOOL)){
            RACSignal *handleURL;
            if (item == nil) {
                handleURL = [RACSignal error:nil];
            } else {
                let url = AUTNotNil([NSURL URLWithString:item.localizedTitle]);
                handleURL = [router.handleURL execute:RACTuplePack(url, nil)];
            }
            
            return [[handleURL
                doCompleted:^{
                    completionHandler(YES);
                }]
                catch:^(NSError *error) {
                    completionHandler(NO);
                    return [RACSignal empty];
                }];
        }]
        flatten];
}

@end

NS_ASSUME_NONNULL_END
