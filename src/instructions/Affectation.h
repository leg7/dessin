#pragma once
#include "Instruction.h"
#include "../Contexte.h"
#include <memory>

class Affectation: public Instruction
{
	protected:
	std::string _nom;

	Affectation(const std::shared_ptr<Contexte> &contexte, const std::string &nom);
	virtual void executer() const override = 0;
};
