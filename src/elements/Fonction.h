#pragma once
#include "../instructions/Instruction.h"
#include "../Contexte.h"
#include <vector>

class Fonction: public Element
{
	public:
	const std::shared_ptr<Contexte> _c;
	std::vector<std::string> _arg_keys;
	std::vector<std::shared_ptr<Instruction>> _then;

	Fonction(const std::shared_ptr<Contexte> &c,
			const std::vector<std::string> &arg_keys,
			const std::vector<std::shared_ptr<Instruction>> &then) noexcept
		: _c(c), _arg_keys(arg_keys), _then(then) {}

	virtual double toDouble() const noexcept override { return 0; }
	virtual Type type() const noexcept override { return Type::Fonction; }
};
