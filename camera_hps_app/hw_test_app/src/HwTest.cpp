// Project : hw_test_app
// File    : HwTest.cpp
#include "HwTest.hpp"

#include "hps_arm_a9_0.h"

namespace HW_TEST
{

    tclsHwTest::tclsHwTest()
    {
        mbActive = true;

        mu16DrawPointMIAddress = reinterpret_cast<unsigned short *>(DRAWPOINT_BASE);

        mu32PixelAddress = 0x0U;

        mu32YOffset = 0x0;

        mu32XOffset = 0x0;
    }

    void tclsHwTest::Initialize()
    {
        // Do nothing
    }

    bool tclsHwTest::Run()
    {
        // Buffer is 320x240 RGB12
        for (unsigned int u32XI = 0U; u32XI < 50; u32XI++)
        {
            for (unsigned int u32YI = 0U; u32YI < 50; u32YI++)
            {
                mu32PixelAddress = ((mu32YOffset + u32YI) * 320U) + (mu32XOffset + u32XI);
                mu16DrawPointMIAddress[mu32PixelAddress] = 0x000000;
            }
        }

        return mbActive;
    }

    void tclsHwTest::Cleanup()
    {
        // Do nothing
    }

    tclsHwTest::~tclsHwTest()
    {
        // Do nothing
    }

} // HW_TEST
