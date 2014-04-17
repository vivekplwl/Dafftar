//
//  AppDelegate.m
//  Dafftar
//
//  Created by apple on 01/04/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SignInViewController.h"
#import "DBClass.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    SignInViewController *test;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            
                       test = [[SignInViewController alloc]     initWithNibName:@"SignInViewControllerSmall" bundle:nil];
            // iPhone Classic
        }
        if(result.height == 568)
        {
           test = [[SignInViewController alloc]     initWithNibName:@"SignInViewController" bundle:nil];
        }
    }
    else
    {
        test = [[SignInViewController alloc]     initWithNibName:@"SignInViewControllerSmall" bundle:nil];
    }
    
   
    UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:test];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
            [self simulatingData];
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"notification recived,%@,set for date %@",notification.alertBody,notification.fireDate);
    
}

-(void)simulatingData
{
    [self performSelectorInBackground:@selector(registeringDatabeseInBackground) withObject:nil];
    
    
}
-(void)registeringDatabeseInBackground
{
    
    DBClass *helper=[[DBClass alloc]init];
    [helper checkAndCreateDatabase];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
