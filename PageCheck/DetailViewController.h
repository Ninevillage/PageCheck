//
//  DetailViewController.h
//  PageCheck
//
//  Created by Nax on 04.04.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
