//
//  NSURL+AUTRoutes.h
//  Example
//
//  Created by Westin Newell on 6/23/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (AUTRoutes)

+ (instancetype)aut_addCatRouteURL;

+ (instancetype)aut_catRouteURLWithCatName:(NSString *)catName;

+ (instancetype)aut_catImageRouteURLWithCatName:(NSString *)catName;

+ (instancetype)aut_aboutRouteURL;

+ (instancetype)aut_faqRouteURL;

@end

extern NSString * const AUTRouteURLScheme;
extern NSString * const AUTRouteURLHost;

extern NSString * const AUTRoutePathComponentCats;
extern NSString * const AUTRoutePathComponentAdd;
extern NSString * const AUTRoutePathComponentDetail;
extern NSString * const AUTRoutePathComponentImage;
extern NSString * const AUTRoutePathComponentAbout;
extern NSString * const AUTRoutePathComponentFAQ;

NS_ASSUME_NONNULL_END
