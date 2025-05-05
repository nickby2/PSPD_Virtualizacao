
#include <gtest/gtest.h>
#include "../../string_processor.pb.h"
#include "../../string_processor.grpc.pb.h"

std::string process_uppercase(const std::string& input) {
    std::string result = input;
    std::transform(result.begin(), result.end(), result.begin(), ::toupper);
    return result;
}

TEST(ServerATest, ConvertsToUppercase) {
    EXPECT_EQ(process_uppercase("hello"), "HELLO");
    EXPECT_EQ(process_uppercase("Test123"), "TEST123");
    EXPECT_EQ(process_uppercase(""), "");
}
