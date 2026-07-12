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

// This header is private to the ProtobolBuffers library and must NOT be
// included by any sources outside this library. The contents of this file are
// subject to change at any time without notice.

#import <WindFoundation/WindGPBDescriptor.h>
#import <WindFoundation/WindGPBWireFormat.h>

// Describes attributes of the field.
typedef NS_OPTIONS(uint16_t, WindGPBFieldFlags) {
  WindGPBFieldNone            = 0,
  // These map to standard protobuf concepts.
  WindGPBFieldRequired        = 1 << 0,
  WindGPBFieldRepeated        = 1 << 1,
  WindGPBFieldPacked          = 1 << 2,
  WindGPBFieldOptional        = 1 << 3,
  WindGPBFieldHasDefaultValue = 1 << 4,

  // Indicate that the field should "clear" when set to zero value. This is the
  // proto3 non optional behavior for singular data (ints, data, string, enum)
  // fields.
  WindGPBFieldClearHasIvarOnZero = 1 << 5,
  // Indicates the field needs custom handling for the TextFormat name, if not
  // set, the name can be derived from the ObjC name.
  WindGPBFieldTextFormatNameCustom = 1 << 6,
  // Indicates the field has an enum descriptor.
  WindGPBFieldHasEnumDescriptor = 1 << 7,

  // These are not standard protobuf concepts, they are specific to the
  // Objective C runtime.

  // These bits are used to mark the field as a map and what the key
  // type is.
  WindGPBFieldMapKeyMask     = 0xF << 8,
  WindGPBFieldMapKeyInt32    =  1 << 8,
  WindGPBFieldMapKeyInt64    =  2 << 8,
  WindGPBFieldMapKeyUInt32   =  3 << 8,
  WindGPBFieldMapKeyUInt64   =  4 << 8,
  WindGPBFieldMapKeySInt32   =  5 << 8,
  WindGPBFieldMapKeySInt64   =  6 << 8,
  WindGPBFieldMapKeyFixed32  =  7 << 8,
  WindGPBFieldMapKeyFixed64  =  8 << 8,
  WindGPBFieldMapKeySFixed32 =  9 << 8,
  WindGPBFieldMapKeySFixed64 = 10 << 8,
  WindGPBFieldMapKeyBool     = 11 << 8,
  WindGPBFieldMapKeyString   = 12 << 8,
};

// NOTE: The structures defined here have their members ordered to minimize
// their size. This directly impacts the size of apps since these exist per
// field/extension.

// Describes a single field in a protobuf as it is represented as an ivar.
typedef struct WindGPBMessageFieldDescription {
  // Name of ivar.
  const char *name;
  union {
    // className is deprecated and will be removed in favor of clazz.
    // kept around right now for backwards compatibility.
    // clazz is used iff WindGPBDescriptorInitializationFlag_UsesClassRefs is set.
    char *className;  // Name of the class of the message.
    Class clazz;  // Class of the message.
    // For enums only: If EnumDescriptors are compiled in, it will be that,
    // otherwise it will be the verifier.
    WindGPBEnumDescriptorFunc enumDescFunc;
    WindGPBEnumValidationFunc enumVerifier;
  } dataTypeSpecific;
  // The field number for the ivar.
  uint32_t number;
  // The index (in bits) into _has_storage_.
  //   >= 0: the bit to use for a value being set.
  //   = WindGPBNoHasBit(INT32_MAX): no storage used.
  //   < 0: in a oneOf, use a full int32 to record the field active.
  int32_t hasIndex;
  // Offset of the variable into it's structure struct.
  uint32_t offset;
  // Field flags. Use accessor functions below.
  WindGPBFieldFlags flags;
  // Data type of the ivar.
  WindGPBDataType dataType;
} WindGPBMessageFieldDescription;

// Fields in messages defined in a 'proto2' syntax file can provide a default
// value. This struct provides the default along with the field info.
typedef struct WindGPBMessageFieldDescriptionWithDefault {
  // Default value for the ivar.
  WindGPBGenericValue defaultValue;

  WindGPBMessageFieldDescription core;
} WindGPBMessageFieldDescriptionWithDefault;

// Describes attributes of the extension.
typedef NS_OPTIONS(uint8_t, WindGPBExtensionOptions) {
  WindGPBExtensionNone          = 0,
  // These map to standard protobuf concepts.
  WindGPBExtensionRepeated      = 1 << 0,
  WindGPBExtensionPacked        = 1 << 1,
  WindGPBExtensionSetWireFormat = 1 << 2,
};

// An extension
typedef struct WindGPBExtensionDescription {
  WindGPBGenericValue defaultValue;
  const char *singletonName;
  // Before 3.12, `extendedClass` was just a `const char *`. Thanks to nested
  // initialization (https://en.cppreference.com/w/c/language/struct_initialization#Nested_initialization)
  // old generated code with `.extendedClass = WindGPBStringifySymbol(Something)`
  // still works; and the current generator can use `extendedClass.clazz`, to
  // pass a Class reference.
  union {
    const char *name;
    Class clazz;
  } extendedClass;
  // Before 3.12, this was `const char *messageOrGroupClassName`. In the
  // initial 3.12 release, we moved the `union messageOrGroupClass`, and failed
  // to realize that would break existing source code for extensions. So to
  // keep existing source code working, we added an unnamed union (C11) to
  // provide both the old field name and the new union. This keeps both older
  // and newer code working.
  // Background: https://github.com/protocolbuffers/protobuf/issues/7555
  union {
    const char *messageOrGroupClassName;
    union {
     const char *name;
     Class clazz;
   } messageOrGroupClass;
  };
  WindGPBEnumDescriptorFunc enumDescriptorFunc;
  int32_t fieldNumber;
  WindGPBDataType dataType;
  WindGPBExtensionOptions options;
} WindGPBExtensionDescription;

typedef NS_OPTIONS(uint32_t, WindGPBDescriptorInitializationFlags) {
  WindGPBDescriptorInitializationFlag_None              = 0,
  WindGPBDescriptorInitializationFlag_FieldsWithDefault = 1 << 0,
  WindGPBDescriptorInitializationFlag_WireFormat        = 1 << 1,

  // This is used as a stopgap as we move from using class names to class
  // references. The runtime needs to support both until we allow a
  // breaking change in the runtime.
  WindGPBDescriptorInitializationFlag_UsesClassRefs     = 1 << 2,

  // This flag is used to indicate that the generated sources already contain
  // the `WindGPBFieldClearHasIvarOnZero` flag and it doesn't have to be computed
  // at startup. This allows older generated code to still work with the
  // current runtime library.
  WindGPBDescriptorInitializationFlag_Proto3OptionalKnown = 1 << 3,
};

@interface WindGPBDescriptor () {
 @package
  NSArray *fields_;
  NSArray *oneofs_;
  uint32_t storageSize_;
}

// fieldDescriptions have to be long lived, they are held as raw pointers.
+ (instancetype)
    allocDescriptorForClass:(Class)messageClass
                  rootClass:(Class)rootClass
                       file:(WindGPBFileDescriptor *)file
                     fields:(void *)fieldDescriptions
                 fieldCount:(uint32_t)fieldCount
                storageSize:(uint32_t)storageSize
                      flags:(WindGPBDescriptorInitializationFlags)flags;

- (instancetype)initWithClass:(Class)messageClass
                         file:(WindGPBFileDescriptor *)file
                       fields:(NSArray *)fields
                  storageSize:(uint32_t)storage
                   wireFormat:(BOOL)wireFormat;

// Called right after init to provide extra information to avoid init having
// an explosion of args. These pointers are recorded, so they are expected
// to live for the lifetime of the app.
- (void)setupOneofs:(const char **)oneofNames
              count:(uint32_t)count
      firstHasIndex:(int32_t)firstHasIndex;
- (void)setupExtraTextInfo:(const char *)extraTextFormatInfo;
- (void)setupExtensionRanges:(const WindGPBExtensionRange *)ranges count:(int32_t)count;
- (void)setupContainingMessageClass:(Class)msgClass;
- (void)setupMessageClassNameSuffix:(NSString *)suffix;

// Deprecated. Use setupContainingMessageClass instead.
- (void)setupContainingMessageClassName:(const char *)msgClassName;

@end

@interface WindGPBFileDescriptor ()
- (instancetype)initWithPackage:(NSString *)package
                     objcPrefix:(NSString *)objcPrefix
                         syntax:(WindGPBFileSyntax)syntax;
- (instancetype)initWithPackage:(NSString *)package
                         syntax:(WindGPBFileSyntax)syntax;
@end

@interface WindGPBOneofDescriptor () {
 @package
  const char *name_;
  NSArray *fields_;
  SEL caseSel_;
}
// name must be long lived.
- (instancetype)initWithName:(const char *)name fields:(NSArray *)fields;
@end

@interface WindGPBFieldDescriptor () {
 @package
  WindGPBMessageFieldDescription *description_;
  WindGPB_UNSAFE_UNRETAINED WindGPBOneofDescriptor *containingOneof_;

  SEL getSel_;
  SEL setSel_;
  SEL hasOrCountSel_;  // *Count for map<>/repeated fields, has* otherwise.
  SEL setHasSel_;
}

// Single initializer
// description has to be long lived, it is held as a raw pointer.
- (instancetype)initWithFieldDescription:(void *)description
                         includesDefault:(BOOL)includesDefault
                           usesClassRefs:(BOOL)usesClassRefs
                     proto3OptionalKnown:(BOOL)proto3OptionalKnown
                                  syntax:(WindGPBFileSyntax)syntax;

@end

@interface WindGPBEnumDescriptor ()
// valueNames, values and extraTextFormatInfo have to be long lived, they are
// held as raw pointers.
+ (instancetype)
    allocDescriptorForName:(NSString *)name
                valueNames:(const char *)valueNames
                    values:(const int32_t *)values
                     count:(uint32_t)valueCount
              enumVerifier:(WindGPBEnumValidationFunc)enumVerifier;
+ (instancetype)
    allocDescriptorForName:(NSString *)name
                valueNames:(const char *)valueNames
                    values:(const int32_t *)values
                     count:(uint32_t)valueCount
              enumVerifier:(WindGPBEnumValidationFunc)enumVerifier
       extraTextFormatInfo:(const char *)extraTextFormatInfo;

- (instancetype)initWithName:(NSString *)name
                  valueNames:(const char *)valueNames
                      values:(const int32_t *)values
                       count:(uint32_t)valueCount
                enumVerifier:(WindGPBEnumValidationFunc)enumVerifier;
@end

@interface WindGPBExtensionDescriptor () {
 @package
  WindGPBExtensionDescription *description_;
}
@property(nonatomic, readonly) WindGPBWireFormat wireType;

// For repeated extensions, alternateWireType is the wireType with the opposite
// value for the packable property.  i.e. - if the extension was marked packed
// it would be the wire type for unpacked; if the extension was marked unpacked,
// it would be the wire type for packed.
@property(nonatomic, readonly) WindGPBWireFormat alternateWireType;

// description has to be long lived, it is held as a raw pointer.
- (instancetype)initWithExtensionDescription:(WindGPBExtensionDescription *)desc
                               usesClassRefs:(BOOL)usesClassRefs;
// Deprecated. Calls above with `usesClassRefs = NO`
- (instancetype)initWithExtensionDescription:(WindGPBExtensionDescription *)desc;

- (NSComparisonResult)compareByFieldNumber:(WindGPBExtensionDescriptor *)other;
@end

CF_EXTERN_C_BEGIN

// Direct access is use for speed, to avoid even internally declaring things
// read/write, etc. The warning is enabled in the project to ensure code calling
// protos can turn on -Wdirect-ivar-access without issues.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

WindGPB_INLINE BOOL WindGPBFieldIsMapOrArray(WindGPBFieldDescriptor *field) {
  return (field->description_->flags &
          (WindGPBFieldRepeated | WindGPBFieldMapKeyMask)) != 0;
}

WindGPB_INLINE WindGPBDataType WindGPBGetFieldDataType(WindGPBFieldDescriptor *field) {
  return field->description_->dataType;
}

WindGPB_INLINE int32_t WindGPBFieldHasIndex(WindGPBFieldDescriptor *field) {
  return field->description_->hasIndex;
}

WindGPB_INLINE uint32_t WindGPBFieldNumber(WindGPBFieldDescriptor *field) {
  return field->description_->number;
}

#pragma clang diagnostic pop

uint32_t WindGPBFieldTag(WindGPBFieldDescriptor *self);

// For repeated fields, alternateWireType is the wireType with the opposite
// value for the packable property.  i.e. - if the field was marked packed it
// would be the wire type for unpacked; if the field was marked unpacked, it
// would be the wire type for packed.
uint32_t WindGPBFieldAlternateTag(WindGPBFieldDescriptor *self);

WindGPB_INLINE BOOL WindGPBHasPreservingUnknownEnumSemantics(WindGPBFileSyntax syntax) {
  return syntax == WindGPBFileSyntaxProto3;
}

WindGPB_INLINE BOOL WindGPBExtensionIsRepeated(WindGPBExtensionDescription *description) {
  return (description->options & WindGPBExtensionRepeated) != 0;
}

WindGPB_INLINE BOOL WindGPBExtensionIsPacked(WindGPBExtensionDescription *description) {
  return (description->options & WindGPBExtensionPacked) != 0;
}

WindGPB_INLINE BOOL WindGPBExtensionIsWireFormat(WindGPBExtensionDescription *description) {
  return (description->options & WindGPBExtensionSetWireFormat) != 0;
}

// Helper for compile time assets.
#ifndef WindGPBInternalCompileAssert
  #if __has_feature(c_static_assert) || __has_extension(c_static_assert)
    #define WindGPBInternalCompileAssert(test, msg) _Static_assert((test), #msg)
  #else
    // Pre-Xcode 7 support.
    #define WindGPBInternalCompileAssertSymbolInner(line, msg) WindGPBInternalCompileAssert ## line ## __ ## msg
    #define WindGPBInternalCompileAssertSymbol(line, msg) WindGPBInternalCompileAssertSymbolInner(line, msg)
    #define WindGPBInternalCompileAssert(test, msg) \
        typedef char WindGPBInternalCompileAssertSymbol(__LINE__, msg) [ ((test) ? 1 : -1) ]
  #endif  // __has_feature(c_static_assert) || __has_extension(c_static_assert)
#endif // WindGPBInternalCompileAssert

// Sanity check that there isn't padding between the field description
// structures with and without a default.
WindGPBInternalCompileAssert(sizeof(WindGPBMessageFieldDescriptionWithDefault) ==
                         (sizeof(WindGPBGenericValue) +
                          sizeof(WindGPBMessageFieldDescription)),
                         DescriptionsWithDefault_different_size_than_expected);

CF_EXTERN_C_END
