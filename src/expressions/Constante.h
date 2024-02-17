#pragma once
#include "Expression.h"
#include "../elements/Element.h"

class Constante: public Expression
{
	std::shared_ptr<Element> _val;
	public:
	Constante(Element val) { _val = std::make_shared<Element>(val); };
	virtual std::shared_ptr<Element> eval() const noexcept override { return std::make_shared<Element>(_val); };
};
