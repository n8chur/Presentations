//
//  NSURL+AUTRoutes.m
//  Example
//
//  Created by Westin Newell on 6/23/17.
//  Copyright © 2017 Automatic Labs. All rights reserved.
//

#import "AUTExtObjC.h"

#import "NSURL+AUTRoutes.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSURL (AUTRoutes)

#pragma mark Public

+ (instancetype)aut_addCatRouteURL {
    return [self aut_routeURLWithPathComponents:@[ AUTRoutePathComponentCats, AUTRoutePathComponentAdd ]];
}

+ (instancetype)aut_catRouteURLWithCatName:(NSString *)catName {
    return [self aut_routeURLWithPathComponents:@[ AUTRoutePathComponentCats, AUTRoutePathComponentDetail, catName ]];
}

+ (instancetype)aut_catImageRouteURLWithCatName:(NSString *)catName {
    return [self aut_routeURLWithPathComponents:@[ AUTRoutePathComponentCats, AUTRoutePathComponentDetail, catName, AUTRoutePathComponentImage ]];
}

+ (instancetype)aut_aboutRouteURL {
    return [self aut_routeURLWithPathComponents:@[ AUTRoutePathComponentAbout ]];
}

+ (instancetype)aut_faqRouteURL {
    return [self aut_routeURLWithPathComponents:@[ AUTRoutePathComponentAbout, AUTRoutePathComponentFAQ ]];
}

#pragma mark Private

+ (instancetype)aut_routeURLWithPathComponents:(NSArray<NSString *> *)pathComponents {
    AUTAssertNotNil(pathComponents);
    
    let components = [[NSURLComponents alloc] init];
    
    components.scheme = AUTRouteURLScheme;
    components.host = AUTRouteURLHost;
    
    // URL component paths require a leading slash.
    pathComponents = [@[ @"/" ] arrayByAddingObjectsFromArray:pathComponents];
    components.path = [NSString pathWithComponents:pathComponents];
    
    return AUTNotNil(components.URL);
}

@end

NSString * const AUTRouteURLScheme = @"pres";
NSString * const AUTRouteURLHost = @"root";

NSString * const AUTRoutePathComponentCats = @"cats";
NSString * const AUTRoutePathComponentAdd = @"add";
NSString * const AUTRoutePathComponentDetail = @"detail";
NSString * const AUTRoutePathComponentImage = @"image";
NSString * const AUTRoutePathComponentAbout = @"about";
NSString * const AUTRoutePathComponentFAQ = @"faq";

NS_ASSUME_NONNULL_END
