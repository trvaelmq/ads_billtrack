// Protocol Buffers - Google's data interchange format
// Copyright 2016 Google Inc.  All rights reserved.
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

#import "WindGPBCodedOutputStream.h"

NS_ASSUME_NONNULL_BEGIN

CF_EXTERN_C_BEGIN

size_t WindGPBComputeDoubleSize(int32_t fieldNumber, double value)
    __attribute__((const));
size_t WindGPBComputeFloatSize(int32_t fieldNumber, float value)
    __attribute__((const));
size_t WindGPBComputeUInt64Size(int32_t fieldNumber, uint64_t value)
    __attribute__((const));
size_t WindGPBComputeInt64Size(int32_t fieldNumber, int64_t value)
    __attribute__((const));
size_t WindGPBComputeInt32Size(int32_t fieldNumber, int32_t value)
    __attribute__((const));
size_t WindGPBComputeFixed64Size(int32_t fieldNumber, uint64_t value)
    __attribute__((const));
size_t WindGPBComputeFixed32Size(int32_t fieldNumber, uint32_t value)
    __attribute__((const));
size_t WindGPBComputeBoolSize(int32_t fieldNumber, BOOL value)
    __attribute__((const));
size_t WindGPBComputeStringSize(int32_t fieldNumber, NSString *value)
    __attribute__((const));
size_t WindGPBComputeGroupSize(int32_t fieldNumber, WindGPBMessage *value)
    __attribute__((const));
size_t WindGPBComputeUnknownGroupSize(int32_t fieldNumber,
                                  WindGPBUnknownFieldSet *value)
    __attribute__((const));
size_t WindGPBComputeMessageSize(int32_t fieldNumber, WindGPBMessage *value)
    __attribute__((const));
size_t WindGPBComputeBytesSize(int32_t fieldNumber, NSData *value)
    __attribute__((const));
size_t WindGPBComputeUInt32Size(int32_t fieldNumber, uint32_t value)
    __attribute__((const));
size_t WindGPBComputeSFixed32Size(int32_t fieldNumber, int32_t value)
    __attribute__((const));
size_t WindGPBComputeSFixed64Size(int32_t fieldNumber, int64_t value)
    __attribute__((const));
size_t WindGPBComputeSInt32Size(int32_t fieldNumber, int32_t value)
    __attribute__((const));
size_t WindGPBComputeSInt64Size(int32_t fieldNumber, int64_t value)
    __attribute__((const));
size_t WindGPBComputeTagSize(int32_t fieldNumber) __attribute__((const));
size_t WindGPBComputeWireFormatTagSize(int field_number, WindGPBDataType dataType)
    __attribute__((const));

size_t WindGPBComputeDoubleSizeNoTag(double value) __attribute__((const));
size_t WindGPBComputeFloatSizeNoTag(float value) __attribute__((const));
size_t WindGPBComputeUInt64SizeNoTag(uint64_t value) __attribute__((const));
size_t WindGPBComputeInt64SizeNoTag(int64_t value) __attribute__((const));
size_t WindGPBComputeInt32SizeNoTag(int32_t value) __attribute__((const));
size_t WindGPBComputeFixed64SizeNoTag(uint64_t value) __attribute__((const));
size_t WindGPBComputeFixed32SizeNoTag(uint32_t value) __attribute__((const));
size_t WindGPBComputeBoolSizeNoTag(BOOL value) __attribute__((const));
size_t WindGPBComputeStringSizeNoTag(NSString *value) __attribute__((const));
size_t WindGPBComputeGroupSizeNoTag(WindGPBMessage *value) __attribute__((const));
size_t WindGPBComputeUnknownGroupSizeNoTag(WindGPBUnknownFieldSet *value)
    __attribute__((const));
size_t WindGPBComputeMessageSizeNoTag(WindGPBMessage *value) __attribute__((const));
size_t WindGPBComputeBytesSizeNoTag(NSData *value) __attribute__((const));
size_t WindGPBComputeUInt32SizeNoTag(int32_t value) __attribute__((const));
size_t WindGPBComputeEnumSizeNoTag(int32_t value) __attribute__((const));
size_t WindGPBComputeSFixed32SizeNoTag(int32_t value) __attribute__((const));
size_t WindGPBComputeSFixed64SizeNoTag(int64_t value) __attribute__((const));
size_t WindGPBComputeSInt32SizeNoTag(int32_t value) __attribute__((const));
size_t WindGPBComputeSInt64SizeNoTag(int64_t value) __attribute__((const));

// Note that this will calculate the size of 64 bit values truncated to 32.
size_t WindGPBComputeSizeTSizeAsInt32NoTag(size_t value) __attribute__((const));

size_t WindGPBComputeRawVarint32Size(int32_t value) __attribute__((const));
size_t WindGPBComputeRawVarint64Size(int64_t value) __attribute__((const));

// Note that this will calculate the size of 64 bit values truncated to 32.
size_t WindGPBComputeRawVarint32SizeForInteger(NSInteger value)
    __attribute__((const));

// Compute the number of bytes that would be needed to encode a
// MessageSet extension to the stream.  For historical reasons,
// the wire format differs from normal fields.
size_t WindGPBComputeMessageSetExtensionSize(int32_t fieldNumber, WindGPBMessage *value)
    __attribute__((const));

// Compute the number of bytes that would be needed to encode an
// unparsed MessageSet extension field to the stream.  For
// historical reasons, the wire format differs from normal fields.
size_t WindGPBComputeRawMessageSetExtensionSize(int32_t fieldNumber, NSData *value)
    __attribute__((const));

size_t WindGPBComputeEnumSize(int32_t fieldNumber, int32_t value)
    __attribute__((const));

CF_EXTERN_C_END

NS_ASSUME_NONNULL_END
