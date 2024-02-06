#pragma once

#include "contexte.hh"

class Instruction {
public:
    virtual void executer(Contexte & contexte) const =0;
};
