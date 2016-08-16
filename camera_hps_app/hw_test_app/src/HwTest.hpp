// Project : hw_test_app
// File    : HwTest.hpp
#ifndef HW_TEST_HWTEST_HPP
#define HW_TEST_HWTEST_HPP

namespace HW_TEST
{

    class tclsHwTest
    {

    public:

        tclsHwTest();

        void Initialize();

        bool Run();

        void Cleanup();

        virtual ~tclsHwTest();

    private:
        bool mbActive;

        unsigned short *mu16DrawPointMIAddress;

        unsigned int mu32PixelAddress;

        unsigned int mu32YOffset;

        unsigned int mu32XOffset;
    };

} // HW_TEST

#endif // HW_TEST_HWTEST_HPP
