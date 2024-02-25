#pragma once
#include "Expression.h"
#include "../elements/ElementSimple.h"

class Constante: public Expression
{
	std::shared_ptr<Element> _val;
	public:
	Constante(double val) { _val = std::make_shared<ElementSimple>(val); }
	Constante(const std::shared_ptr<Element> &val): _val(val) {}
	virtual std::shared_ptr<Element> eval() const noexcept override { return _val; };
};
