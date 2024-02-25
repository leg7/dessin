#include "ExpressionUnaire.h"

std::shared_ptr<Element> ExpressionUnaire::eval() const noexcept
{
	double result = 0;
	switch (_operateur) {
		case Operation::NEG: result = _operande->eval()->toDouble() == 0 ? 1 : 0; break;
		case Operation::MIN: result = -_operande->eval()->toDouble(); break;
		case Operation::NOOP: result = _operande->eval()->toDouble();
	}
	return nullptr;
}

