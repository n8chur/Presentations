//
//  RACCommand+AUTPresentation.m
//  AUTPresentations
//
//  Created by James Lawton on 1/21/16.
//  Copyright © 2016 Automatic Labs. All rights reserved.
//

@import AUTExtReactiveCocoa;

#import "AUTExtObjC.h"
#import "AUTPresentation.h"
#import "AUTCancellableViewModel.h"

#import "RACCommand+AUTPresentation.h"

NS_ASSUME_NONNULL_BEGIN

@interface AUTPresentCommandExecutionContext ()

- (instancetype)initWithPresentation:(id<AUTPresentation>)presentation viewModel:(nullable id)viewModel presentationAnimated:(nullable NSNumber *)presentationAnimated dismissalAnimated:(nullable NSNumber *)dismissalAnimated NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly, copy, nullable) NSNumber *presentationAnimated;
@property (nonatomic, readonly, copy, nullable) NSNumber *dismissalAnimated;

@end

@implementation RACCommand (AUTPresentation)

+ (RACCommand *)aut_presentCommandWithExecutionBlock:(AUTPresentCommandExecutionBlock)executionBlock {
    AUTAssertNotNil(executionBlock);

    executionBlock = [executionBlock copy];

    let enabled = [RACSubject subject];

    return [[RACCommand alloc] initWithEnabled:enabled signalBlock:^(id input) {
        let present = ^{
            let context = executionBlock(input);
            if (context == nil) return [RACSignal empty];

            // If the presentation is dismissible, ensure that the command is
            // disabled while presenting.
            if ([context.presentation conformsToProtocol:@protocol(AUTDismissiblePresentation)]) {
                let dismissiblePresentation = (id<AUTDismissiblePresentation>)context.presentation;

                [enabled sendNext:@NO];

                // Re-enable the command once the presentation is dismissed.
                [dismissiblePresentation.didDismiss subscribeNext:^(id _) {
                    [enabled sendNext:@YES];
                }];

                // If the view model is cancellable, ensure that we execute its
                // cancellation command if interrupted and dismissed by a consumer.
                //
                // If the presentation has been dismissed _because_ of its cancel
                // command being executed, the command will be disabled and thus
                // executing it will have no effect.
                //
                // If the presentation has been dismissed due to its result signal
                // completing, the cancel command will be disabled and thus
                // executing it will have no effect.
                if ([context.viewModel conformsToProtocol:@protocol(AUTCancellableViewModel)]) {
                    let viewModel = (id<AUTCancellableViewModel>)context.viewModel;

                    [dismissiblePresentation.didDismiss subscribeNext:^(id _) {
                        [viewModel.cancel execute:nil];
                    }];
                }
            }
            
            RACSignal *presentCommandExecution;

            // If the presentation vends a result, dismiss when there is one.
            if ([context.presentation conformsToProtocol:@protocol(AUTResultPresentation)]) {
                let resultPresentation = (id<AUTResultPresentation>)context.presentation;
                let executionValue = RACTuplePack(context.presentationAnimated, context.dismissalAnimated);
                presentCommandExecution = [[resultPresentation.presentUntilResult execute:executionValue]
                    ignoreValues];
            }
            // Otherwise, just present when executed.
            else {
                presentCommandExecution = [[context.presentation.present execute:context.presentationAnimated]
                    ignoreValues];
            }
            
            if (context.viewModel) {
                return [presentCommandExecution startWith:context.viewModel];
            } else {
                return presentCommandExecution;
            }
        };
       
        // Ensure the presentation signalBlock evaluation occurs on the main
        // thread scheduler, otherwise view controllers could be created from
        // a background thread.
        if (NSThread.isMainThread) return present();

        return [[RACSignal defer:present]
            subscribeOn:RACScheduler.mainThreadScheduler];
    }];
}

@end

@implementation AUTPresentCommandExecutionContext

- (instancetype)init AUT_UNAVAILABLE_DESIGNATED_INITIALIZER;

- (instancetype)initWithPresentation:(id<AUTPresentation>)presentation viewModel:(nullable id)viewModel presentationAnimated:(nullable NSNumber *)presentationAnimated dismissalAnimated:(nullable NSNumber *)dismissalAnimated {
    AUTAssertNotNil(presentation);

    self = [super init];

    _presentation = presentation;
    _viewModel = viewModel;
    _presentationAnimated = [presentationAnimated copy];
    _dismissalAnimated = [dismissalAnimated copy];

    return self;
}

+ (instancetype)contextWithPresentation:(id<AUTPresentation>)presentation ofViewModel:(nullable id)viewModel animated:(nullable NSNumber *)animated {
    return [[self alloc] initWithPresentation:presentation viewModel:viewModel presentationAnimated:animated dismissalAnimated:nil];
}

+ (instancetype)contextWithPresentation:(id<AUTDismissiblePresentation>)presentation ofViewModel:(nullable id)viewModel presentationAnimated:(nullable NSNumber *)presentationAnimated dismissalAnimated:(nullable NSNumber *)dismissalAnimated {
    return [[self alloc] initWithPresentation:presentation viewModel:viewModel presentationAnimated:presentationAnimated dismissalAnimated:dismissalAnimated];
}

@end

NS_ASSUME_NONNULL_END
