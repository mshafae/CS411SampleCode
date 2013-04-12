//
//  MSViewController.m
//  BSDFortune
//
//  Created by Michael Shafae on 4/9/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "MSViewController.h"
#import "FortuneDatabase.h"

@interface MSViewController ()

@end

@implementation MSViewController

@synthesize webView;

- (void)touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
  MSAphorism* aphorism = [[FortuneDatabase database] next];
  [(UIWebView*)self.webView loadHTMLString: aphorism.HTMLtext baseURL: nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  MSAphorism* aphorism = [[FortuneDatabase database] next];
  [(UIWebView*)self.webView loadHTMLString: aphorism.HTMLtext baseURL: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonPressed:(id)sender {
  //NSLog(@"Description %@", [sender description]);
  MSAphorism* aphorism = [[FortuneDatabase database] next];
  [(UIWebView*)self.webView loadHTMLString: aphorism.HTMLtext baseURL: nil];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
  
}

/*- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
  
}*/

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
  //NSLog(@"Finished loading web view.");
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
  //NSLog(@"Started loading web view.");
}
@end
