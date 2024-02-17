#include "ExpressionBinaire.h"
#include "../elements/ElementPrimitif.h"
#include <memory>

std::shared_ptr<Element> ExpressionBinaire::eval() const noexcept
{
	double result;
	switch (_op) {
		case Operation::ADD: result = _gauche->eval()->toDouble() + _droite->eval()->toDouble(); break;
		case Operation::SUB: result = _gauche->eval()->toDouble() - _droite->eval()->toDouble(); break;
		case Operation::MUL: result = _gauche->eval()->toDouble() * _droite->eval()->toDouble(); break;
		case Operation::DIV: result = _gauche->eval()->toDouble() / _droite->eval()->toDouble(); break;
		case Operation::EQ:  result = _gauche->eval()->toDouble() == _droite->eval()->toDouble(); break;
		case Operation::GT:  result = _gauche->eval()->toDouble() > _droite->eval()->toDouble(); break;
		case Operation::GE:  result = _gauche->eval()->toDouble() >= _droite->eval()->toDouble(); break;
		case Operation::LT:  result = _gauche->eval()->toDouble() < _droite->eval()->toDouble(); break;
		case Operation::LE:  result = _gauche->eval()->toDouble() <= _droite->eval()->toDouble();
	}
	return std::make_shared<Element>(ElementPrimitif<double>(result));
}

