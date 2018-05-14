# Presentations

Presentations uses [ReactiveObjC](http://github.com/ReactiveCocoa/ReactiveObjC) to make presenting content reactive on iOS. With Presentations you can use [commands](https://github.com/ReactiveCocoa/ReactiveObjC/blob/master/ReactiveObjC/RACCommand.h) to present new content. Presentations is designed to intregrate cleanly into the MVVM pattern in a way where your view presentations can be unit tested without instantiating any `UIViewController`s.

## Usage

First we need to define a presenter protocol. This is what the presenting navigation controller will conform to:
```objective-c
@protocol RootNavigationModelPresenter

- (id<AUTPresentation>)presentChild:(ChildViewModel *)viewModel;

@end
```

Next, we need to add a presenter property to our navigation view model and define a present command.
```objective-c
@interface RootNavigationModel : NSObject

@property (nonatomic, weak) id<RootNavigationModelPresenter> presenter;

@property (readonly, nonatomic) RACCommand<id, ChildViewModel *> *presentChild;

@end
```

In our implementation for our navigation view model we need to initialize the present command:
```objective-c
_presentChild = [RACCommand aut_presentCommandWithExecutionBlock:^ AUTPresentCommandExecutionContext * _Nullable (id _) {
    @strongify(self);
    id<RootNavigationModelPresenter> presenter = self.presenter;
    if (self == nil || presenter == nil) return nil;
    
    ChildViewModel *child = [[ChildViewModel alloc] init];
    
    id<AUTPresentation> presentation = [presenter presentChild:child];
    return [AUTPresentCommandExecutionContext contextWithPresentation:presentation ofViewModel:child animated:@NO];
}];
```

Finally, we need to set our navigation controller as the presenter and conform to our newly created protocol:
```objective-c
@implementation RootNavigationController

- (instancetype)initWithNavigationModel:(RootViewModel *)navigationModel {
    RootViewController *rootViewController = [[RootViewController alloc] init];
    self = [super initWithRootViewController:rootViewController];
    
    _navigationModel = navigationModel;
    _navigationModel.presenter = self;
    
    return self;
}

- (id<AUTPresentation>)presentChild:(ChildViewModel *)viewModel {
    ChildViewModel *viewController = [[ChildViewModel alloc] initWithViewModel:viewModel];
    return [self aut_presentationForViewController:viewController];
}

```

Now we can simply execute the presentation command it will present the child view model
```objective-c
RootNavigationModel *rootNavigationModel = [[RootNavigationModel alloc] init];
RootNavigationController *rootNavigationController = [[RootNavigationController alloc] initWithNavigationModel:rootNavigationModel];

[rootNavigationModel.presentChild execute:nil];
```

While the presentation is in progress the command will be disabled, which is great when you're hooking up these commands to buttons that you don't want to be executed while a presenantation is in progress. ReactiveObjC's UIKit bindings handle this for us:
```objective-c
button.rac_command = rootNavigationModel.presentChild;
```

You can use Presentations for more than just pushing view controllers, you could write your own presentations of your protocol methods to do any of the following:
- [Present a modal view controller](AUTPresentations/AUTModalPresenter.h)
- [Change tabs on a `UITabBarController`](AUTPresentations/UITabBarController+AUTPresentation.h)
- [Swap a view controller using view controller containment](Example/RootViewController.m)
- And more!

Dig through the [Example](Example/) scheme in the [framework project](AUTPresentations.xcodeproj) for more examples.

For deeplinking support check out [Routing](https://github.com/automatic/Routing) (used in the Example).

### Installing

Presentations supports [Carthage](https://github.com/Carthage/Carthage).

To build the project locally, first run:
```bash
$ make bootstrap
```
Then open the [project](AUTPresentations.xcodeproj).

## Built With

* [ReactiveObjC](https://github.com/ReactiveCocoa/ReactiveObjC) - [Functional Reactive Programming](https://en.wikipedia.org/wiki/Functional_reactive_programming)

## Contributing

Fork the repository and and open a pull request to the master branch.

Please report any issues found on Github in the issues section.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/Automatic/Presentations/tags).
