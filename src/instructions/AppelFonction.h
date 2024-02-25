#include "Instruction.h"

class AppelFonction: public Instruction
{
	std::string _cle_fonction;
	std::vector<std::shared_ptr<Expression>> _args;
	public:
	AppelFonction(const std::shared_ptr<Contexte> &c,
			const std::string &fonction,
			const std::vector<std::shared_ptr<Expression>> args)
		: Instruction(c), _cle_fonction(fonction), _args(args) {}

	virtual void executer() const override;
};
