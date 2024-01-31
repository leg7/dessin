#pragma once
#include <memory>
#include <string>

class Forme {
public:
    virtual std::string to_svg() const = 0;
};
