
find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS} ../../)

add_executable(test_server_b test_server_b.cpp ../../string_processor.pb.cc ../../string_processor.grpc.pb.cc)
target_link_libraries(test_server_b ${GTEST_LIBRARIES} pthread)

add_test(NAME ServerATests COMMAND test_server_b)
