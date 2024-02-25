#include "AppelFonction.h"
#include "../elements/Fonction.h"
#include <stdexcept>

void AppelFonction::executer() const
{
	const auto fn = std::dynamic_pointer_cast<Fonction>(_contexte->at(_cle_fonction));
	Contexte copy = *fn->_c;

	if (_args.size() != fn->_arg_keys.size()) {
		throw std::invalid_argument("Mauvais nombre d'arguments");
	}

	for (size_t i = 0; i < fn->_arg_keys.size(); ++i) {
		copy.add(fn->_arg_keys[i], _args[i]->eval());
	}

	for (const auto &it: fn->_then) {
		*it->_contexte = copy;
		it->executer();
	}
}
