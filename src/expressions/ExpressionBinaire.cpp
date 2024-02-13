#include "ExpressionBinaire.h"
#include <memory>

std::shared_ptr<Element> ExpressionBinaire::calculer() const noexcept
{
	switch (_op) {
		case Operation::ADD: return _gauche->calculer() + _droite->calculer();
		case Operation::SUB: return _gauche->calculer() - _droite->calculer();
		case Operation::MUL: return _gauche->calculer() * _droite->calculer();
		case Operation::DIV: return _gauche->calculer() / _droite->calculer();
		case Operation::EQ:  return _gauche->calculer() == _droite->calculer();
		case Operation::GT:  return _gauche->calculer() > _droite->calculer();
		case Operation::GE:  return _gauche->calculer() >= _droite->calculer();
		case Operation::LT:  return _gauche->calculer() < _droite->calculer();
		case Operation::LE:  return _gauche->calculer() <= _droite->calculer();
	}
}
