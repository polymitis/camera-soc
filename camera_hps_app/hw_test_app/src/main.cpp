// Project : hw_test_app
// File    : main.cpp

#include "HwTest.hpp"

int main()
{
    HW_TEST::tclsHwTest HwTestApp;

    HwTestApp.Initialize();

    bool bActive = true;
    while (bActive)
    {
        bActive = HwTestApp.Run();
    }

    HwTestApp.Cleanup();

}

