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

#import <WindFoundation/WindGPBRuntimeTypes.h>

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

typedef enum {
  WindGPBWireFormatVarint = 0,
  WindGPBWireFormatFixed64 = 1,
  WindGPBWireFormatLengthDelimited = 2,
  WindGPBWireFormatStartGroup = 3,
  WindGPBWireFormatEndGroup = 4,
  WindGPBWireFormatFixed32 = 5,
} WindGPBWireFormat;

enum {
  WindGPBWireFormatMessageSetItem = 1,
  WindGPBWireFormatMessageSetTypeId = 2,
  WindGPBWireFormatMessageSetMessage = 3
};

uint32_t WindGPBWireFormatMakeTag(uint32_t fieldNumber, WindGPBWireFormat wireType)
    __attribute__((const));
WindGPBWireFormat WindGPBWireFormatGetTagWireType(uint32_t tag) __attribute__((const));
uint32_t WindGPBWireFormatGetTagFieldNumber(uint32_t tag) __attribute__((const));
BOOL WindGPBWireFormatIsValidTag(uint32_t tag) __attribute__((const));

WindGPBWireFormat WindGPBWireFormatForType(WindGPBDataType dataType, BOOL isPacked)
    __attribute__((const));

#define WindGPBWireFormatMessageSetItemTag \
  (WindGPBWireFormatMakeTag(WindGPBWireFormatMessageSetItem, WindGPBWireFormatStartGroup))
#define WindGPBWireFormatMessageSetItemEndTag \
  (WindGPBWireFormatMakeTag(WindGPBWireFormatMessageSetItem, WindGPBWireFormatEndGroup))
#define WindGPBWireFormatMessageSetTypeIdTag \
  (WindGPBWireFormatMakeTag(WindGPBWireFormatMessageSetTypeId, WindGPBWireFormatVarint))
#define WindGPBWireFormatMessageSetMessageTag               \
  (WindGPBWireFormatMakeTag(WindGPBWireFormatMessageSetMessage, \
                        WindGPBWireFormatLengthDelimited))

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END
