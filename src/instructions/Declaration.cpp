#include "Declaration.h"
#include <stdexcept>

Declaration::Declaration(const std::shared_ptr<Contexte> &contexte, std::shared_ptr<Element> val, std::string nom):
	Instruction(contexte), _nom(nom), _val(val)
{
}

void Declaration::executer() const
{
	if (_nom != "") {
		if (_contexte->contains(_nom)) {
			throw std::invalid_argument("Impossible de declarer, la variable existe deja");
		}
		_contexte->add(_nom, _val);
	} else {
		_contexte->addForme(std::dynamic_pointer_cast<Forme>(_val));
	}
}

