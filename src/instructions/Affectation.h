#pragma once
#include "Instruction.h"
#include "../Contexte.h"
#include <memory>

class Affectation: public Instruction
{
	std::string _nom;
	std::shared_ptr<Element> _elem;

	public:
	Affectation(const std::shared_ptr<Contexte> &contexte, const std::string &nom, const std::shared_ptr<Element> &elem): Instruction(contexte), _nom(nom), _elem(elem) {}
	virtual void executer() const noexcept override;
};
