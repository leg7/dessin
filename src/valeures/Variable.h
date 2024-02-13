#pragma once
#include <memory>
#include "Valeure.h"
#include "../elements/Element.h"

class Variable: public Valeure
{
	// ptr to Element of contexte
	std::shared_ptr<Element> _val;

	public:
	Variable(std::shared_ptr<Element> val): _val(val) {}
	virtual Element val() const noexcept override { return *_val; }
};
