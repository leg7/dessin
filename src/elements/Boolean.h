#pragma once
#include "Element.h"

class Boolean: public Element
{
	bool _val;
	public:
	Boolean(bool val) noexcept: Element(Type::Boolean), _val(val) {}
	float val() const noexcept { return _val; };
};
