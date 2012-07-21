//
//  TTEvilCase.m
//  EonilCocoaComplements-SQLite
//
//  Created by Hoon Hwangbo on 1/22/12.
//  Copyright (c) 2012 Eonil Company. All rights reserved.
//

#import "TTEvilCase.h"
#import "EonilCocoaComplementsSQLite.h"


@implementation TTEvilCase
{
}
- (void)setUp
{
    [super setUp];
}
- (void)tearDown
{
    [super tearDown];
}





- (void)testBadPathToDatabaseFile
{
	NSError*			err		=	nil;
	EESQLiteDatabase*	db		=	[[EESQLiteDatabase alloc] initAsPersistentDatabaseOnDiskAtPath:nil error:&err];
	NSLog(@"error = %@", err);
	STAssertNil(db, @"`db` must be nil when offer bad path.");
}
- (void)testInsertingNil
{
	EESQLiteDatabase*		db		=	[EESQLiteDatabase temporaryDatabaseInMemory];
	STAssertNotNil(db, @"");
	
	NSArray*		colnms	=	[NSArray arrayWithObjects:@"column1", @"column2", @"column3", @"column4", nil];
	
	[db addTableWithName:@"Table1" withColumnNames:colnms];
	
	NSError*	err;
	[db insertDictionaryValue:nil intoTable:@"Table1" error:&err];
	NSLog(@"error = %@", err);
	STAssertNil(err, @"Should be no error.");
	
	
	NSArray*	list	=	[db arrayOfValuesByExecutingSQL:@"SELECT * FROM 'Table1'"];
	
//	STAssertTrue([list count] == 0, @"The count of result must be 0. `INSERT` should be no-op.");
	STAssertTrue([list count] == 1, @"The count of list must be 1.");
	STAssertTrue([[list lastObject] count] == 0, @"The result row must be empty.");
}
- (void)testInsertingEmptyDictionary
{
	EESQLiteDatabase*		db		=	[EESQLiteDatabase temporaryDatabaseInMemory];
	STAssertNotNil(db, @"");
	
	NSArray*		colnms	=	[NSArray arrayWithObjects:@"column1", @"column2", @"column3", @"column4", nil];
	
	[db addTableWithName:@"Table1" withColumnNames:colnms];
	
	NSDictionary*	dict1		=	[NSDictionary dictionary];
	
	NSError*	err;
	[db insertDictionaryValue:dict1 intoTable:@"Table1" error:&err];
	NSLog(@"error = %@", err);
	STAssertNil(err, @"Should be no error.");
	
	
	NSArray*		list		=	[db arrayOfValuesByExecutingSQL:@"SELECT * FROM 'Table1'"];
	NSDictionary*	dict2		=	[list lastObject];
	
	STAssertTrue([list count] == 1, @"The count of list must be 1.");
	STAssertTrue([dict2 count] == 0, @"The result row must be empty.");
}


//- (void)testLMemoryLeak
//{
//	for (NSUInteger i=0; i<100000; i++)
//	{
//		@autoreleasepool 
//		{
//			EESQLiteDatabase*	db	=	[[EESQLiteDatabase alloc] initWithDatabaseAtPath:TTPathToTestDatabase() error:NULL];
//			
//			if (i % 10000 == 0)
//			{
//				NSLog(@"db instance creation #%d, db = %@", i, db);
//			}
//		}
//	}
//}
@end