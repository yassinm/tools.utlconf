UTLAPPS_google_test_init(){
    UTLAPPS_google_test_env
}

UTLAPPS_google_test_env(){
    GOOGLE-TEST_ROOT="${UTL3RDP_APPS}/google-test"

    GOOGLE-TEST_VER="google-test-1.6.0"
    GOOGLE-TEST_DIR="${GOOGLE-TEST_ROOT}/${GOOGLE-TEST_VER}"

    #export PATH=${GOOGLE-TEST_DIR}:${PATH}

}

UTLAPPS_google_test_misc(){
    cmake -DCMAKE_BUILD_TYPE=Release

    #To enable link-time optimisation, use
    cmake .. -DCMAKE_BUILD_TYPE=Release -DBENCHMARK_ENABLE_LTO=true


}
                                        
