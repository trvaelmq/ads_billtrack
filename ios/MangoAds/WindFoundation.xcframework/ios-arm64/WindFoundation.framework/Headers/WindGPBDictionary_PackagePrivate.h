// Protocol Buffers - Google's data interchange format
// Copyright 2008 Google Inc.  All rights reserved.
// https://developers.google.com/protocol-buffers/
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import <Foundation/Foundation.h>

#import "WindGPBDictionary.h"

@class WindGPBCodedInputStream;
@class WindGPBCodedOutputStream;
@class WindGPBExtensionRegistry;
@class WindGPBFieldDescriptor;

@protocol WindGPBDictionaryInternalsProtocol
- (size_t)computeSerializedSizeAsField:(WindGPBFieldDescriptor *)field;
- (void)writeToCodedOutputStream:(WindGPBCodedOutputStream *)outputStream
                         asField:(WindGPBFieldDescriptor *)field;
- (void)setWindGPBGenericValue:(WindGPBGenericValue *)value
     forWindGPBGenericValueKey:(WindGPBGenericValue *)key;
- (void)enumerateForTextFormat:(void (^)(id keyObj, id valueObj))block;
@end

//%PDDM-DEFINE DICTIONARY_PRIV_INTERFACES_FOR_POD_KEY(KEY_NAME)
//%DICTIONARY_POD_PRIV_INTERFACES_FOR_KEY(KEY_NAME)
//%DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, Object, Object)
//%PDDM-DEFINE DICTIONARY_POD_PRIV_INTERFACES_FOR_KEY(KEY_NAME)
//%DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, UInt32, Basic)
//%DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, Int32, Basic)
//%DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, UInt64, Basic)
//%DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, Int64, Basic)
//%DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, Bool, Basic)
//%DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, Float, Basic)
//%DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, Double, Basic)
//%DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, Enum, Enum)

//%PDDM-DEFINE DICTIONARY_PRIVATE_INTERFACES(KEY_NAME, VALUE_NAME, HELPER)
//%@interface WindGPB##KEY_NAME##VALUE_NAME##Dictionary () <WindGPBDictionaryInternalsProtocol> {
//% @package
//%  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
//%}
//%EXTRA_DICTIONARY_PRIVATE_INTERFACES_##HELPER()@end
//%

//%PDDM-DEFINE EXTRA_DICTIONARY_PRIVATE_INTERFACES_Basic()
// Empty
//%PDDM-DEFINE EXTRA_DICTIONARY_PRIVATE_INTERFACES_Object()
//%- (BOOL)isInitialized;
//%- (instancetype)deepCopyWithZone:(NSZone *)zone
//%    __attribute__((ns_returns_retained));
//%
//%PDDM-DEFINE EXTRA_DICTIONARY_PRIVATE_INTERFACES_Enum()
//%- (NSData *)serializedDataForUnknownValue:(int32_t)value
//%                                   forKey:(WindGPBGenericValue *)key
//%                              keyDataType:(WindGPBDataType)keyDataType;
//%

//%PDDM-EXPAND DICTIONARY_PRIV_INTERFACES_FOR_POD_KEY(UInt32)
// This block of code is generated, do not edit it directly.
// clang-format off

@interface WindGPBUInt32UInt32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt32Int32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt32UInt64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt32Int64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt32BoolDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt32FloatDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt32DoubleDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt32EnumDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (NSData *)serializedDataForUnknownValue:(int32_t)value
                                   forKey:(WindGPBGenericValue *)key
                              keyDataType:(WindGPBDataType)keyDataType;
@end

@interface WindGPBUInt32ObjectDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (BOOL)isInitialized;
- (instancetype)deepCopyWithZone:(NSZone *)zone
    __attribute__((ns_returns_retained));
@end

// clang-format on
//%PDDM-EXPAND DICTIONARY_PRIV_INTERFACES_FOR_POD_KEY(Int32)
// This block of code is generated, do not edit it directly.
// clang-format off

@interface WindGPBInt32UInt32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt32Int32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt32UInt64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt32Int64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt32BoolDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt32FloatDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt32DoubleDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt32EnumDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (NSData *)serializedDataForUnknownValue:(int32_t)value
                                   forKey:(WindGPBGenericValue *)key
                              keyDataType:(WindGPBDataType)keyDataType;
@end

@interface WindGPBInt32ObjectDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (BOOL)isInitialized;
- (instancetype)deepCopyWithZone:(NSZone *)zone
    __attribute__((ns_returns_retained));
@end

// clang-format on
//%PDDM-EXPAND DICTIONARY_PRIV_INTERFACES_FOR_POD_KEY(UInt64)
// This block of code is generated, do not edit it directly.
// clang-format off

@interface WindGPBUInt64UInt32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt64Int32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt64UInt64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt64Int64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt64BoolDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt64FloatDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt64DoubleDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBUInt64EnumDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (NSData *)serializedDataForUnknownValue:(int32_t)value
                                   forKey:(WindGPBGenericValue *)key
                              keyDataType:(WindGPBDataType)keyDataType;
@end

@interface WindGPBUInt64ObjectDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (BOOL)isInitialized;
- (instancetype)deepCopyWithZone:(NSZone *)zone
    __attribute__((ns_returns_retained));
@end

// clang-format on
//%PDDM-EXPAND DICTIONARY_PRIV_INTERFACES_FOR_POD_KEY(Int64)
// This block of code is generated, do not edit it directly.
// clang-format off

@interface WindGPBInt64UInt32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt64Int32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt64UInt64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt64Int64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt64BoolDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt64FloatDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt64DoubleDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBInt64EnumDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (NSData *)serializedDataForUnknownValue:(int32_t)value
                                   forKey:(WindGPBGenericValue *)key
                              keyDataType:(WindGPBDataType)keyDataType;
@end

@interface WindGPBInt64ObjectDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (BOOL)isInitialized;
- (instancetype)deepCopyWithZone:(NSZone *)zone
    __attribute__((ns_returns_retained));
@end

// clang-format on
//%PDDM-EXPAND DICTIONARY_PRIV_INTERFACES_FOR_POD_KEY(Bool)
// This block of code is generated, do not edit it directly.
// clang-format off

@interface WindGPBBoolUInt32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBBoolInt32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBBoolUInt64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBBoolInt64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBBoolBoolDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBBoolFloatDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBBoolDoubleDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBBoolEnumDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (NSData *)serializedDataForUnknownValue:(int32_t)value
                                   forKey:(WindGPBGenericValue *)key
                              keyDataType:(WindGPBDataType)keyDataType;
@end

@interface WindGPBBoolObjectDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (BOOL)isInitialized;
- (instancetype)deepCopyWithZone:(NSZone *)zone
    __attribute__((ns_returns_retained));
@end

// clang-format on
//%PDDM-EXPAND DICTIONARY_POD_PRIV_INTERFACES_FOR_KEY(String)
// This block of code is generated, do not edit it directly.
// clang-format off

@interface WindGPBStringUInt32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBStringInt32Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBStringUInt64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBStringInt64Dictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBStringBoolDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBStringFloatDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBStringDoubleDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

@interface WindGPBStringEnumDictionary () <WindGPBDictionaryInternalsProtocol> {
 @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
- (NSData *)serializedDataForUnknownValue:(int32_t)value
                                   forKey:(WindGPBGenericValue *)key
                              keyDataType:(WindGPBDataType)keyDataType;
@end

// clang-format on
//%PDDM-EXPAND-END (6 expansions)

#pragma mark - NSDictionary Subclass

@interface WindGPBAutocreatedDictionary : NSMutableDictionary {
  @package
  WindGPB_UNSAFE_UNRETAINED WindGPBMessage *_autocreator;
}
@end

#pragma mark - Helpers

CF_EXTERN_C_BEGIN

// Helper to compute size when an NSDictionary is used for the map instead
// of a custom type.
size_t WindGPBDictionaryComputeSizeInternalHelper(NSDictionary *dict,
                                              WindGPBFieldDescriptor *field);

// Helper to write out when an NSDictionary is used for the map instead
// of a custom type.
void WindGPBDictionaryWriteToStreamInternalHelper(
    WindGPBCodedOutputStream *outputStream, NSDictionary *dict,
    WindGPBFieldDescriptor *field);

// Helper to check message initialization when an NSDictionary is used for
// the map instead of a custom type.
BOOL WindGPBDictionaryIsInitializedInternalHelper(NSDictionary *dict,
                                              WindGPBFieldDescriptor *field);

// Helper to read a map instead.
void WindGPBDictionaryReadEntry(id mapDictionary, WindGPBCodedInputStream *stream,
                            WindGPBExtensionRegistry *registry,
                            WindGPBFieldDescriptor *field,
                            WindGPBMessage *parentMessage);

CF_EXTERN_C_END
