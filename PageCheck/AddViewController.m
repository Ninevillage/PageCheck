//
//  AddViewController.m
//  PageCheck
//
//  Created by Nax on 04.04.14.
//  Copyright (c) 2014 Ninevillage. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *domainField;

- (IBAction)onSave:(id)sender;
- (BOOL)validate;
- (BOOL)validateDomain;
@end

@implementation AddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.nameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onSave:(id)sender {
    if (![self validate]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Name and Domain are required. Domain must be a valid URL." delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:self.nameField.text forKey:@"name"];
    [newManagedObject setValue:self.domainField.text forKey:@"domain"];
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)validate {
    BOOL valid = YES;
    if (self.nameField.text.length == 0) {
        valid = NO;
    }
    if (self.domainField.text.length == 0 || ![self validateDomain]) {
        valid = NO;
    }
    return valid;
}

- (BOOL)validateDomain {
    BOOL valid = YES;
    NSString *urlRegEx = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    valid = [urlTest evaluateWithObject:self.domainField.text];
    
    return valid;
}

# pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameField) {
        [self.domainField becomeFirstResponder];
    } else if (textField == self.domainField) {
        [self onSave:self.domainField];
    }
    return true;
}
@end
