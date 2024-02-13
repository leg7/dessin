#pragma once
#include "Instruction.h"
#include "../elements/Element.h"
#include "../Contexte.h"
#include <string>

class Declaration: public Instruction
{
	std::string _nom;
	Element _val;

	public:
	Declaration(std::string nom, Element val): _nom(nom), _val(val) {}
	void ajouterAuContexte(Contexte &c) const noexcept;
};
