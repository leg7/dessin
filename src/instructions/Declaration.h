#pragma once
#include "Instruction.h"
#include "../elements/Element.h"
#include "../Contexte.h"
#include <string>

class Declaration: public Instruction
{
	std::string _nom;
	std::shared_ptr<Element> _val;

	public:
	Declaration(const std::shared_ptr<Contexte> &contexte,
			std::string nom,
			std::shared_ptr<Element> val) noexcept:
		Instruction(contexte), _nom(nom), _val(val) {}

	virtual void executer() const noexcept override;
};
