//
//  AddViewController.h
//  PageCheck
//
//  Created by Nax on 04.04.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
