#pragma once
#include "Instruction.h"
#include "../elements/Element.h"
#include "../Contexte.h"
#include <memory>
#include <string>
#include "../elements/formes/Forme.h"

class Declaration: public Instruction
{
	std::string _nom;
	std::shared_ptr<Element> _val;

	public:
	Declaration(const std::shared_ptr<Contexte> &contexte, std::shared_ptr<Element> val, std::string nom = "");

	virtual void executer() const override;
};
