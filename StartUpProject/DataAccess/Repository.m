//
//  Repository.m
//  Events
//
//  Created by James Hall on 8/19/10.
//  Copyright 2010 James Hall. All rights reserved.
//

#import "Repository.h"

@implementation Repository

@synthesize managedObjectContext = _managedObjectContext;

#pragma mark - Access
+(Repository*) beginTransaction; {
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[AppDelegate Instance] persistentStoreCoordinator];
    Repository *repository = [[Repository alloc] init];
    repository.managedObjectContext =
    [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [repository.managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    return repository;
}

-(NSError*) endTransaction
{
    NSError *error = nil;
    if(!self.managedObjectContext)
        error = [NSError errorWithDomain:@"Current context is nil. Please create repository entity with [Repository beginTransaction] command." code:0 userInfo:nil];
    else if ([self.managedObjectContext hasChanges]) {
        [self.managedObjectContext save:&error];
    }
    return error;
}

#pragma mark - Create
-(NSManagedObject *) createEntity:(Class)entityClass
{
    NSString *entityName = NSStringFromClass(entityClass);
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    return (NSManagedObject *)newManagedObject;
}

#pragma mark - Delete
-(void)deleteEntity:(NSManagedObject *)event
{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:event];
}

#pragma mark - Fetch

- (NSArray *) getResultsFromEntity:(Class)entityClass
{
	return [self getResultsFromEntity:entityClass predicateOrNil:nil];
}

- (NSArray *) getResultsFromEntity:(Class)entityClass predicateOrNil:(NSPredicate *)predicateOrNil;
{
	return [self getResultsFromEntity:entityClass predicateOrNil:predicateOrNil ascSortStringOrNil:nil descSortStringOrNil:nil];
}

- (NSArray *) getResultsFromEntity:(Class)entityClass predicateOrNil:(NSPredicate *)predicateOrNil ascSortStringOrNil:(NSArray *)ascSortStringOrNil descSortStringOrNil:(NSArray *)descSortStringOrNil
{
    NSString *entityName = NSStringFromClass(entityClass);
	NSFetchRequest *request = [[NSFetchRequest alloc] init]; 
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
											  inManagedObjectContext:[self managedObjectContext]]; 
	[request setEntity:entity]; 
	
	if(predicateOrNil != nil)
	{
		[request setPredicate:predicateOrNil];
	}
	
	NSMutableArray *sortDescriptors = [[NSMutableArray alloc]init];
	
	if(ascSortStringOrNil != nil)
	{
		for (NSString *asc in ascSortStringOrNil)
		{
			NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:asc ascending:YES];
			[sortDescriptors addObject:sortDescriptor];
		}
    }
	if(descSortStringOrNil != nil)
	{
		for (NSString *desc in descSortStringOrNil)
		{
			NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:desc ascending:NO];
			[sortDescriptors addObject:sortDescriptor];
		}
    }
    [request setSortDescriptors:sortDescriptors];
	
	NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
	return results;
}

@end
