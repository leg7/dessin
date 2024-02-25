#include "Instruction.h"

class DeclarationFonction: public Instruction
{
	std::string _key;
	std::shared_ptr<Element> _val;

	public:
	Declaration(const std::shared_ptr<Contexte> &contexte, std::shared_ptr<Element> val, std::string nom = "");

	virtual void executer() const override;

}
