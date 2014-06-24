//
//  EESQLiteCommon.m
//  EonilSQLite
//
//  Created by Hoon Hwangbo on 5/24/13.
//  Copyright (c) 2013 Eonil Company. All rights reserved.
//



#import "EESQLiteCommon.h"
#import "EESQLiteDatabase.h"
#import "EESQLite____internal_doctor.h"



BOOL
EESQLiteIsDebuggingMode()
{
#ifdef	EESQLITE_DEBUG
	return	YES;
#else
	return	NO;
#endif
}


void
EESQLiteAssert(BOOL condition, NSString* message)
{
	if (EESQLiteIsDebuggingMode() && !condition)
	{
		NSString*	reason	=	[@"EESQLite assertion failure!!! " stringByAppendingString:message];
		EESQLiteExcept(reason);
	}
}

void
EESQLiteExcept(NSString* reason)
{
	@throw	[NSException exceptionWithName:@"EESQLITE-EXCEPTION" reason:reason userInfo:nil];
}



void
EESQLiteExceptIfThereIsAnError(NSError* error)
{
	if (error != nil)
	{
		EESQLiteExcept([error description]);
	}
}






void
EESQLiteExceptIfIdentifierIsInvalid(NSString* identifier)
{
	if (![EESQLiteDatabase isValidIdentifierString:identifier])
	{
		EESQLiteExcept([NSString stringWithFormat:@"The name %@ is invalid for SQLite3. Only alphanumeric and underscore letters are permitted. This is Objective-C wrapper level error.", identifier]);
	}
}





































#if EONIL_DEBUG_MODE

void
_universe_error_log(NSString* message)
{
	NSLog(@"[Universe/Error/Log] %@", message);
}

void
UNIVERSE_DEBUG_ASSERT(BOOL cond)
{
	[EESQLite____internal_doctor panicIf:!cond withMessage:@"Debugging assertion failure!"];
}
void
UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(BOOL cond, NSString* message)
{
	[EESQLite____internal_doctor panicIf:!cond withMessage:message];
}

void
UNIVERSE_UNREACHABLE_CODE()
{
	[EESQLite____internal_doctor panicWithMessage:@"Unreacable code! (asserted for debugging)"];
	__builtin_unreachable();
}

#endif














