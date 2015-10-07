# Demo-TabBarController

## Who is suitable for this

1. You want to switch several ViewControllers directly.
2. You don't want to implement complex delegate methods by yourself.
3. You don't want to hold a TabBar.
4. You are unfamiliar with UITabBarControllerDelegate and you don't want to use it.

## How to use

1. Create a property of type SCTTabManager  in your main ViewController.
2. Use initialization method *initWithDelegate:withHiddenTabBar:*.
3. Make your ViewController adapt to *SCTTabbedViewManagerDelegate*.
4. Implement delegate methods.

## Init method

####initWithDelegate:withHiddenTabBar:

1. It makes you easy to add the view of TabBarController to the view of your ViewController.
2. It will automatically to setup the layout if you give it the ViewControllers.
3. Hide TabBar if you want to switch ViewControllers by yourself.

## Delegate methods

  - tabbedViewControllers

You need to make an array of UIViewControllers for the tabs.

  - tabBarItemTitles
  - tabBarItemImages
  - tabBarItemSelectedImages

You can provide the NSString as the titles, image and selected image names. It will automatically create UITabBarItem if you need.
You should provide as least one of them if you don't hide the TabBar.

## Other Note

If you HIDE UITabBar, you can call *selectTabViewIndex:* to switch the ViewController.
If you want to use UITabBarControllerDelegate, you can change the initialization method of SCTTabManager to set the delegate of the tabBarController and implement delegate methods in your ViewController.m.
