#pragma once
#include <memory>
#include "Expression.h"
#include "../elements/Element.h"

class Variable: public Expression
{
	// ptr to Element of contexte
	std::shared_ptr<Element> _val;

	public:
	Variable(std::shared_ptr<Element> val): _val(val) {}
	virtual std::shared_ptr<Element> eval() const noexcept override { return _val; };
};
