-- |
-- Module      :  Foundation.System.Bindings.Time
-- Maintainer  :  Haskell foundation
--

module Foundation.System.Bindings.Time where

import Foundation.Internal.Base
import Foundation.Primitive.Types.OffsetSize
import Foreign.C.Types

#include <time.h>
#include <sys/time.h>

type CClockId = CInt
data CTimeSpec
data CTimeVal
data CTimeZone

size_CTimeSpec :: CSize
size_CTimeSpec = #const sizeof(struct timespec)

ofs_CTimeSpec_Seconds :: Offset Word8
ofs_CTimeSpec_Seconds = Offset (#offset struct timespec, tv_sec)

ofs_CTimeSpec_NanoSeconds :: Offset Word8
ofs_CTimeSpec_NanoSeconds = Offset (#offset struct timespec, tv_nsec)

size_CTimeVal :: CSize
size_CTimeVal = #const sizeof(struct timeval)

size_CTimeZone :: CSize
size_CTimeZone = #const sizeof(struct timezone)

size_CTimeT :: CSize
size_CTimeT = #const sizeof(time_t)

#if defined __APPLE__

#include <Availability.h>

#if !defined(__MAC_10_12) || __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_12

#define CLOCK_REALTIME 0
#define CLOCK_MONOTONIC 1
#define CLOCK_PROCESS_CPUTIME_ID 2
#define CLOCK_THREAD_CPUTIME_ID 3

#define FOUNDATION_SYSTEM_API_NO_CLOCK

#endif

#endif

sysTime_CLOCK_REALTIME
    , sysTime_CLOCK_MONOTONIC :: CClockId
sysTime_CLOCK_REALTIME = (#const CLOCK_REALTIME)
sysTime_CLOCK_MONOTONIC = (#const CLOCK_MONOTONIC)

sysTime_CLOCK_PROCESS_CPUTIME_ID :: CClockId
sysTime_CLOCK_PROCESS_CPUTIME_ID = (#const CLOCK_PROCESS_CPUTIME_ID)

sysTime_CLOCK_THREAD_CPUTIME_ID :: CClockId
sysTime_CLOCK_THREAD_CPUTIME_ID = (#const CLOCK_THREAD_CPUTIME_ID)

#ifdef CLOCK_MONOTONIC_RAW
sysTime_CLOCK_MONOTONIC_RAW :: CClockId
sysTime_CLOCK_MONOTONIC_RAW = (#const CLOCK_MONOTONIC_RAW)
#endif

#ifdef CLOCK_REALTIME_COARSE
sysTime_CLOCK_REALTIME_COARSE :: CClockId
sysTime_CLOCK_REALTIME_COARSE = (#const CLOCK_REALTIME_COARSE)
#endif

#ifdef CLOCK_MONOTIC_COARSE
sysTime_CLOCK_MONOTONIC_COARSE :: CClockId
sysTime_CLOCK_MONOTONIC_COARSE = (#const CLOCK_MONOTONIC_COARSE)
#endif

#ifdef CLOCK_BOOTTIME
sysTime_CLOCK_BOOTTIME :: CClockId
sysTime_CLOCK_BOOTTIME = (#const CLOCK_BOOTTIME)
#endif

#ifdef CLOCK_REALTIME_ALARM
sysTime_CLOCK_REALTIME_ALARM :: CClockId
sysTime_CLOCK_REALTIME_ALARM = (#const CLOCK_REALTIME_ALARM)
#endif

#ifdef CLOCK_BOOTTIME_ALARM
sysTime_CLOCK_BOOTTIME_ALARM :: CClockId
sysTime_CLOCK_BOOTTIME_ALARM = (#const CLOCK_BOOTTIME_ALARM)
#endif

#ifdef CLOCK_TAI
sysTime_CLOCK_TAI :: CClockId
sysTime_CLOCK_TAI = (#const CLOCK_TAI)
#endif

#ifdef FOUNDATION_SYSTEM_API_NO_CLOCK
foreign import ccall unsafe "foundation_time_clock_getres"
    sysTimeClockGetRes :: CClockId -> Ptr CTimeSpec -> IO CInt
foreign import ccall unsafe "foundation_time_clock_gettime"
    sysTimeClockGetTime :: CClockId -> Ptr CTimeSpec -> IO CInt
#else
foreign import ccall unsafe "clock_getres"
    sysTimeClockGetRes :: CClockId -> Ptr CTimeSpec -> IO CInt
foreign import ccall unsafe "clock_gettime"
    sysTimeClockGetTime :: CClockId -> Ptr CTimeSpec -> IO CInt
#endif

foreign import ccall unsafe "gettimeofday"
    sysTimeGetTimeOfDay :: Ptr CTimeVal -> Ptr CTimeZone -> IO CInt
