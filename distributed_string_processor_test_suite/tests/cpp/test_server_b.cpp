
#include <gtest/gtest.h>
#include "../../string_processor.pb.h"
#include "../../string_processor.grpc.pb.h"

std::string process_reverse(const std::string& input) {
    return std::string(input.rbegin(), input.rend());
}

TEST(ServerBTest, ReversesString) {
    EXPECT_EQ(process_reverse("hello"), "olleh");
    EXPECT_EQ(process_reverse("12345"), "54321");
    EXPECT_EQ(process_reverse(""), "");
}
