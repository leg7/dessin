#pragma once
#include "Element.h"

class Entier: public Element
{
	int _val;
	public:
	Entier(int val) noexcept: Element(Type::Entier), _val(val) {}
	int val() const noexcept { return _val; };
};
