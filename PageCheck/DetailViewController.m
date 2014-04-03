//
//  DetailViewController.m
//  PageCheck
//
//  Created by Nax on 04.04.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.title = [[self.detailItem valueForKey:@"name"] description];
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
        NSURL *url = [NSURL URLWithString:[[self.detailItem valueForKey:@"domain"] description]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Domain could not load." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    NSLog(@"Error : %@",error);
}

@end
