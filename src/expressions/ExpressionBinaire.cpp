#include "ExpressionBinaire.h"
#include <memory>

std::shared_ptr<Element> ExpressionBinaire::eval() const noexcept
{
	double result = 0;
	switch (_op) {
		case Operation::ADD: result = _gauche->eval()->toDouble() + _droite->eval()->toDouble(); break;
		case Operation::SUB: result = _gauche->eval()->toDouble() - _droite->eval()->toDouble(); break;
		case Operation::MUL: result = _gauche->eval()->toDouble() * _droite->eval()->toDouble(); break;
		case Operation::DIV: result = _gauche->eval()->toDouble() / _droite->eval()->toDouble(); break;
		case Operation::EQ:  result = _gauche->eval()->toDouble() == _droite->eval()->toDouble(); break;
		case Operation::NE:  result = _gauche->eval()->toDouble() != _droite->eval()->toDouble(); break;
		case Operation::GT:  result = _gauche->eval()->toDouble() > _droite->eval()->toDouble(); break;
		case Operation::GE:  result = _gauche->eval()->toDouble() >= _droite->eval()->toDouble(); break;
		case Operation::LT:  result = _gauche->eval()->toDouble() < _droite->eval()->toDouble(); break;
		case Operation::LE:  result = _gauche->eval()->toDouble() <= _droite->eval()->toDouble(); break;
		case Operation::AND: result = _gauche->eval()->toDouble() && _droite->eval()->toDouble(); break;
		case Operation::OR:  result = _gauche->eval()->toDouble() || _droite->eval()->toDouble(); break;
	}
	return nullptr;
}

