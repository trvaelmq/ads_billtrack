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

#import <WindFoundation/WindGPBUtilities.h>

#import <WindFoundation/WindGPBDescriptor_PackagePrivate.h>

// Macros for stringifying library symbols. These are used in the generated
// WindGPB descriptor classes wherever a library symbol name is represented as a
// string.
#define WindGPBStringify(S) #S
#define WindGPBStringifySymbol(S) WindGPBStringify(S)

#define WindGPBNSStringify(S) @#S
#define WindGPBNSStringifySymbol(S) WindGPBNSStringify(S)

// Macros for generating a Class from a class name. These are used in
// the generated WindGPB descriptor classes wherever an Objective C class
// reference is needed for a generated class.
#define WindGPBObjCClassSymbol(name) OBJC_CLASS_$_##name
#define WindGPBObjCClass(name) \
    ((__bridge Class)&(WindGPBObjCClassSymbol(name)))
#define WindGPBObjCClassDeclaration(name) \
    extern const WindGPBObjcClass_t WindGPBObjCClassSymbol(name)

// Constant to internally mark when there is no has bit.
#define WindGPBNoHasBit INT32_MAX

CF_EXTERN_C_BEGIN

// These two are used to inject a runtime check for version mismatch into the
// generated sources to make sure they are linked with a supporting runtime.
void WindGPBCheckRuntimeVersionSupport(int32_t objcRuntimeVersion);
WindGPB_INLINE void WindGPB_DEBUG_CHECK_RUNTIME_VERSIONS() {
  // NOTE: By being inline here, this captures the value from the library's
  // headers at the time the generated code was compiled.
#if defined(DEBUG) && DEBUG
  WindGPBCheckRuntimeVersionSupport(GOOGLE_PROTOBUF_OBJC_VERSION);
#endif
}

// Legacy version of the checks, remove when GOOGLE_PROTOBUF_OBJC_GEN_VERSION
// goes away (see more info in WindGPBBootstrap.h).
void WindGPBCheckRuntimeVersionInternal(int32_t version);
WindGPB_INLINE void WindGPBDebugCheckRuntimeVersion() {
#if defined(DEBUG) && DEBUG
  WindGPBCheckRuntimeVersionInternal(GOOGLE_PROTOBUF_OBJC_GEN_VERSION);
#endif
}

// Conversion functions for de/serializing floating point types.

WindGPB_INLINE int64_t WindGPBConvertDoubleToInt64(double v) {
  WindGPBInternalCompileAssert(sizeof(double) == sizeof(int64_t), double_not_64_bits);
  int64_t result;
  memcpy(&result, &v, sizeof(result));
  return result;
}

WindGPB_INLINE int32_t WindGPBConvertFloatToInt32(float v) {
  WindGPBInternalCompileAssert(sizeof(float) == sizeof(int32_t), float_not_32_bits);
  int32_t result;
  memcpy(&result, &v, sizeof(result));
  return result;
}

WindGPB_INLINE double WindGPBConvertInt64ToDouble(int64_t v) {
  WindGPBInternalCompileAssert(sizeof(double) == sizeof(int64_t), double_not_64_bits);
  double result;
  memcpy(&result, &v, sizeof(result));
  return result;
}

WindGPB_INLINE float WindGPBConvertInt32ToFloat(int32_t v) {
  WindGPBInternalCompileAssert(sizeof(float) == sizeof(int32_t), float_not_32_bits);
  float result;
  memcpy(&result, &v, sizeof(result));
  return result;
}

WindGPB_INLINE int32_t WindGPBLogicalRightShift32(int32_t value, int32_t spaces) {
  return (int32_t)((uint32_t)(value) >> spaces);
}

WindGPB_INLINE int64_t WindGPBLogicalRightShift64(int64_t value, int32_t spaces) {
  return (int64_t)((uint64_t)(value) >> spaces);
}

// Decode a ZigZag-encoded 32-bit value.  ZigZag encodes signed integers
// into values that can be efficiently encoded with varint.  (Otherwise,
// negative values must be sign-extended to 64 bits to be varint encoded,
// thus always taking 10 bytes on the wire.)
WindGPB_INLINE int32_t WindGPBDecodeZigZag32(uint32_t n) {
  return (int32_t)(WindGPBLogicalRightShift32((int32_t)n, 1) ^ -((int32_t)(n) & 1));
}

// Decode a ZigZag-encoded 64-bit value.  ZigZag encodes signed integers
// into values that can be efficiently encoded with varint.  (Otherwise,
// negative values must be sign-extended to 64 bits to be varint encoded,
// thus always taking 10 bytes on the wire.)
WindGPB_INLINE int64_t WindGPBDecodeZigZag64(uint64_t n) {
  return (int64_t)(WindGPBLogicalRightShift64((int64_t)n, 1) ^ -((int64_t)(n) & 1));
}

// Encode a ZigZag-encoded 32-bit value.  ZigZag encodes signed integers
// into values that can be efficiently encoded with varint.  (Otherwise,
// negative values must be sign-extended to 64 bits to be varint encoded,
// thus always taking 10 bytes on the wire.)
WindGPB_INLINE uint32_t WindGPBEncodeZigZag32(int32_t n) {
  // Note:  the right-shift must be arithmetic
  return ((uint32_t)n << 1) ^ (uint32_t)(n >> 31);
}

// Encode a ZigZag-encoded 64-bit value.  ZigZag encodes signed integers
// into values that can be efficiently encoded with varint.  (Otherwise,
// negative values must be sign-extended to 64 bits to be varint encoded,
// thus always taking 10 bytes on the wire.)
WindGPB_INLINE uint64_t WindGPBEncodeZigZag64(int64_t n) {
  // Note:  the right-shift must be arithmetic
  return ((uint64_t)n << 1) ^ (uint64_t)(n >> 63);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wswitch-enum"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

WindGPB_INLINE BOOL WindGPBDataTypeIsObject(WindGPBDataType type) {
  switch (type) {
    case WindGPBDataTypeBytes:
    case WindGPBDataTypeString:
    case WindGPBDataTypeMessage:
    case WindGPBDataTypeGroup:
      return YES;
    default:
      return NO;
  }
}

WindGPB_INLINE BOOL WindGPBDataTypeIsMessage(WindGPBDataType type) {
  switch (type) {
    case WindGPBDataTypeMessage:
    case WindGPBDataTypeGroup:
      return YES;
    default:
      return NO;
  }
}

WindGPB_INLINE BOOL WindGPBFieldDataTypeIsMessage(WindGPBFieldDescriptor *field) {
  return WindGPBDataTypeIsMessage(field->description_->dataType);
}

WindGPB_INLINE BOOL WindGPBFieldDataTypeIsObject(WindGPBFieldDescriptor *field) {
  return WindGPBDataTypeIsObject(field->description_->dataType);
}

WindGPB_INLINE BOOL WindGPBExtensionIsMessage(WindGPBExtensionDescriptor *ext) {
  return WindGPBDataTypeIsMessage(ext->description_->dataType);
}

// The field is an array/map or it has an object value.
WindGPB_INLINE BOOL WindGPBFieldStoresObject(WindGPBFieldDescriptor *field) {
  WindGPBMessageFieldDescription *desc = field->description_;
  if ((desc->flags & (WindGPBFieldRepeated | WindGPBFieldMapKeyMask)) != 0) {
    return YES;
  }
  return WindGPBDataTypeIsObject(desc->dataType);
}

BOOL WindGPBGetHasIvar(WindGPBMessage *self, int32_t index, uint32_t fieldNumber);
void WindGPBSetHasIvar(WindGPBMessage *self, int32_t idx, uint32_t fieldNumber,
                   BOOL value);
uint32_t WindGPBGetHasOneof(WindGPBMessage *self, int32_t index);

WindGPB_INLINE BOOL
WindGPBGetHasIvarField(WindGPBMessage *self, WindGPBFieldDescriptor *field) {
  WindGPBMessageFieldDescription *fieldDesc = field->description_;
  return WindGPBGetHasIvar(self, fieldDesc->hasIndex, fieldDesc->number);
}

#pragma clang diagnostic pop

//%PDDM-DEFINE WindGPB_IVAR_SET_DECL(NAME, TYPE)
//%void WindGPBSet##NAME##IvarWithFieldPrivate(WindGPBMessage *self,
//%            NAME$S                    WindGPBFieldDescriptor *field,
//%            NAME$S                    TYPE value);
//%PDDM-EXPAND WindGPB_IVAR_SET_DECL(Bool, BOOL)
// This block of code is generated, do not edit it directly.
// clang-format off

void WindGPBSetBoolIvarWithFieldPrivate(WindGPBMessage *self,
                                    WindGPBFieldDescriptor *field,
                                    BOOL value);
// clang-format on
//%PDDM-EXPAND WindGPB_IVAR_SET_DECL(Int32, int32_t)
// This block of code is generated, do not edit it directly.
// clang-format off

void WindGPBSetInt32IvarWithFieldPrivate(WindGPBMessage *self,
                                     WindGPBFieldDescriptor *field,
                                     int32_t value);
// clang-format on
//%PDDM-EXPAND WindGPB_IVAR_SET_DECL(UInt32, uint32_t)
// This block of code is generated, do not edit it directly.
// clang-format off

void WindGPBSetUInt32IvarWithFieldPrivate(WindGPBMessage *self,
                                      WindGPBFieldDescriptor *field,
                                      uint32_t value);
// clang-format on
//%PDDM-EXPAND WindGPB_IVAR_SET_DECL(Int64, int64_t)
// This block of code is generated, do not edit it directly.
// clang-format off

void WindGPBSetInt64IvarWithFieldPrivate(WindGPBMessage *self,
                                     WindGPBFieldDescriptor *field,
                                     int64_t value);
// clang-format on
//%PDDM-EXPAND WindGPB_IVAR_SET_DECL(UInt64, uint64_t)
// This block of code is generated, do not edit it directly.
// clang-format off

void WindGPBSetUInt64IvarWithFieldPrivate(WindGPBMessage *self,
                                      WindGPBFieldDescriptor *field,
                                      uint64_t value);
// clang-format on
//%PDDM-EXPAND WindGPB_IVAR_SET_DECL(Float, float)
// This block of code is generated, do not edit it directly.
// clang-format off

void WindGPBSetFloatIvarWithFieldPrivate(WindGPBMessage *self,
                                     WindGPBFieldDescriptor *field,
                                     float value);
// clang-format on
//%PDDM-EXPAND WindGPB_IVAR_SET_DECL(Double, double)
// This block of code is generated, do not edit it directly.
// clang-format off

void WindGPBSetDoubleIvarWithFieldPrivate(WindGPBMessage *self,
                                      WindGPBFieldDescriptor *field,
                                      double value);
// clang-format on
//%PDDM-EXPAND-END (7 expansions)

void WindGPBSetEnumIvarWithFieldPrivate(WindGPBMessage *self,
                                    WindGPBFieldDescriptor *field,
                                    int32_t value);

id WindGPBGetObjectIvarWithField(WindGPBMessage *self, WindGPBFieldDescriptor *field);

void WindGPBSetObjectIvarWithFieldPrivate(WindGPBMessage *self,
                                      WindGPBFieldDescriptor *field, id value);
void WindGPBSetRetainedObjectIvarWithFieldPrivate(WindGPBMessage *self,
                                              WindGPBFieldDescriptor *field,
                                              id __attribute__((ns_consumed))
                                              value);

// WindGPBGetObjectIvarWithField will automatically create the field (message) if
// it doesn't exist. WindGPBGetObjectIvarWithFieldNoAutocreate will return nil.
id WindGPBGetObjectIvarWithFieldNoAutocreate(WindGPBMessage *self,
                                         WindGPBFieldDescriptor *field);

// Clears and releases the autocreated message ivar, if it's autocreated. If
// it's not set as autocreated, this method does nothing.
void WindGPBClearAutocreatedMessageIvarWithField(WindGPBMessage *self,
                                             WindGPBFieldDescriptor *field);

// Returns an Objective C encoding for |selector|. |instanceSel| should be
// YES if it's an instance selector (as opposed to a class selector).
// |selector| must be a selector from MessageSignatureProtocol.
const char *WindGPBMessageEncodingForSelector(SEL selector, BOOL instanceSel);

// Helper for text format name encoding.
// decodeData is the data describing the special decodes.
// key and inputString are the input that needs decoding.
NSString *WindGPBDecodeTextFormatName(const uint8_t *decodeData, int32_t key,
                                  NSString *inputString);


// Shims from the older generated code into the runtime.
void WindGPBSetInt32IvarWithFieldInternal(WindGPBMessage *self,
                                      WindGPBFieldDescriptor *field,
                                      int32_t value,
                                      WindGPBFileSyntax syntax);
void WindGPBMaybeClearOneof(WindGPBMessage *self, WindGPBOneofDescriptor *oneof,
                        int32_t oneofHasIndex, uint32_t fieldNumberNotToClear);

// A series of selectors that are used solely to get @encoding values
// for them by the dynamic protobuf runtime code. See
// WindGPBMessageEncodingForSelector for details. WindGPBRootObject conforms to
// the protocol so that it is encoded in the Objective C runtime.
@protocol WindGPBMessageSignatureProtocol
@optional

#define WindGPB_MESSAGE_SIGNATURE_ENTRY(TYPE, NAME) \
  -(TYPE)get##NAME;                             \
  -(void)set##NAME : (TYPE)value;               \
  -(TYPE)get##NAME##AtIndex : (NSUInteger)index;

WindGPB_MESSAGE_SIGNATURE_ENTRY(BOOL, Bool)
WindGPB_MESSAGE_SIGNATURE_ENTRY(uint32_t, Fixed32)
WindGPB_MESSAGE_SIGNATURE_ENTRY(int32_t, SFixed32)
WindGPB_MESSAGE_SIGNATURE_ENTRY(float, Float)
WindGPB_MESSAGE_SIGNATURE_ENTRY(uint64_t, Fixed64)
WindGPB_MESSAGE_SIGNATURE_ENTRY(int64_t, SFixed64)
WindGPB_MESSAGE_SIGNATURE_ENTRY(double, Double)
WindGPB_MESSAGE_SIGNATURE_ENTRY(int32_t, Int32)
WindGPB_MESSAGE_SIGNATURE_ENTRY(int64_t, Int64)
WindGPB_MESSAGE_SIGNATURE_ENTRY(int32_t, SInt32)
WindGPB_MESSAGE_SIGNATURE_ENTRY(int64_t, SInt64)
WindGPB_MESSAGE_SIGNATURE_ENTRY(uint32_t, UInt32)
WindGPB_MESSAGE_SIGNATURE_ENTRY(uint64_t, UInt64)
WindGPB_MESSAGE_SIGNATURE_ENTRY(NSData *, Bytes)
WindGPB_MESSAGE_SIGNATURE_ENTRY(NSString *, String)
WindGPB_MESSAGE_SIGNATURE_ENTRY(WindGPBMessage *, Message)
WindGPB_MESSAGE_SIGNATURE_ENTRY(WindGPBMessage *, Group)
WindGPB_MESSAGE_SIGNATURE_ENTRY(int32_t, Enum)

#undef WindGPB_MESSAGE_SIGNATURE_ENTRY

- (id)getArray;
- (NSUInteger)getArrayCount;
- (void)setArray:(NSArray *)array;
+ (id)getClassValue;
@end

BOOL WindGPBClassHasSel(Class aClass, SEL sel);

CF_EXTERN_C_END
