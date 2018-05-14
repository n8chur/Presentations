//
//  ApplicationShortcutManager.h
//  Example
//
//  Created by Westin Newell on 6/22/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import UIKit;
@import AUTRouting;

NS_ASSUME_NONNULL_BEGIN

/// A protocol that matches the UIApplicationDelegate method to perform
/// actions for a UIApplicationShortcutItem.
@protocol ApplicationShortcutItemActionHandler <NSObject>

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler;

@end

@interface ApplicationShortcutManager : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithRouter:(AUTRouter *)router handler:(NSObject<ApplicationShortcutItemActionHandler> *)handler;

@property (readonly, nonatomic) NSArray<UIApplicationShortcutItem *> *items;

@end

NS_ASSUME_NONNULL_END
