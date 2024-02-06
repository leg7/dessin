#pragma once

#include <string>

#include "instruction.hh"
#include "expression.hh"

class Affectation: public Instruction {
public:
    Affectation(std::string const& identifiant, ExpressionPtr valeur);

    void executer(Contexte & contexte) const override;

private:
    std::string _identifiant;
    ExpressionPtr _valeur;
};
